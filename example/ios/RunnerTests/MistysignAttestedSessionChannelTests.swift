// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

import Flutter
import XCTest

private let create = "MistysignAttestedSession#create"
private let authBeginRequestData = "MistysignAttestedSession#authBeginRequestData"
private let authEnd = "MistysignAttestedSession#authEnd"
private let encrypt = "MistysignAttestedSession#encrypt"
private let decrypt = "MistysignAttestedSession#decrypt"
private let deattest = "MistysignAttestedSession#deattest"
private let isAttested = "MistysignAttestedSession#isAttested"
private let destroy = "MistysignAttestedSession#destroy"

/// A real handshake needs an enclave to answer, so these cover the boundary the
/// relay drives: the states each call is refused in, and the codes it is refused
/// with.
final class MistysignAttestedSessionChannelTests: PluginChannelTestCase {

    /// The staging Mistysign signer. Any well formed measurement gets past the
    /// empty-set guard, which is all these need.
    private static let mrSignerHex =
        "7ee5e29d74623fdbc6fbf1454be6f3bb0b86c12366b7b478ad13353e44de8411"

    private var id = 0

    override func setUp() {
        super.setUp()
        id = invoke(create) as? Int ?? 0
    }

    override func tearDown() {
        _ = invoke(destroy, ["id": id])
        super.tearDown()
    }

    func testCreateHandsBackAnUnattestedSession() {
        XCTAssertEqual(invoke(isAttested, ["id": id]) as? Bool, false)
    }

    func testEachSessionGetsItsOwnHandle() {
        // Handles come from the object's address, so a collision would hand two
        // relays the same session.
        let other = invoke(create) as? Int

        XCTAssertNotNil(other)
        XCTAssertNotEqual(other, id)

        _ = invoke(destroy, ["id": other ?? 0])
    }

    func testAuthBeginProducesAHandshakeAndLeavesTheSessionUnattested() {
        let request = invoke(authBeginRequestData, ["id": id, "responderId": "misty.test:443"])

        XCTAssertFalse((request as? Data ?? Data()).isEmpty)
        // Reporting a pending handshake as attested would have the relay send
        // messages no enclave has a key for.
        XCTAssertEqual(invoke(isAttested, ["id": id]) as? Bool, false)
    }

    func testAuthBeginWithAnEmptyResponderIdIsRejected() {
        // Without the plugin's own guard this does not fail, it traps the
        // process: the SDK reaches the handshake through
        // withMcMutableBufferInfallible, whose failure is a Swift fatalError.
        assertFails(authBeginRequestData, ["id": id, "responderId": ""],
                    code: "NATIVE")

        // The session has to stay usable, rather than being left holding a
        // half started handshake.
        XCTAssertFalse((invoke(authBeginRequestData,
                               ["id": id, "responderId": "misty.test:443"]) as? Data
                        ?? Data()).isEmpty)
    }

    func testEncryptBeforeAuthEndIsRejected() {
        assertFails(encrypt, ["id": id, "plaintext": bytes([1, 2, 3])],
                    code: "MISTYSIGN_NOT_ATTESTED")
    }

    func testDecryptBeforeAuthEndIsRejected() {
        assertFails(decrypt, ["id": id, "messageData": bytes([1, 2, 3])],
                    code: "MISTYSIGN_NOT_ATTESTED")
    }

    func testAuthEndWithoutTrustedIdentitiesIsRejected() {
        // The guard has to fire ahead of the handshake state check: an empty set
        // can never match evidence, so it is a caller mistake either way.
        assertFails(authEnd, arguments(for: id, mrSigners: []),
                    code: "MISTYSIGN_NO_TRUSTED_IDENTITIES")
    }

    func testAuthEndBeforeAuthBeginIsRejected() {
        assertFails(authEnd, arguments(for: id, mrSigners: [Self.mrSignerEntry()]),
                    code: "MISTYSIGN_ATTESTATION_FAILED")
    }

    func testAnUnreadableIdentityIsNotReportedAsAFailedAttestation() {
        // A local configuration fault, so it must not arrive under the code an
        // enclave whose evidence did not match uses. Those two want different
        // triage and Dart can only tell them apart by the code.
        //
        // The handshake is deliberately not begun: reaching this code proves
        // the identity was rejected before the state check that
        // testAuthEndBeforeAuthBeginIsRejected pins.
        for entry in [Self.mrSignerEntry(overriding: "mrSigner", with: "not hex"),
                      Self.mrSignerEntry(overriding: "productId", with: 70000),
                      Self.mrSignerEntry(overriding: "minimumSecurityVersion", with: "6"),
                      Self.mrSignerEntry(overriding: "hardeningAdvisories", with: 7)] {
            assertFails(authEnd, arguments(for: id, mrSigners: [entry]),
                        code: "MISTYSIGN_INVALID_TRUSTED_IDENTITY")
        }
    }

    func testAnUnreadableEnclaveMeasurementIsRejected() {
        let arguments: [String: Any] = [
            "id": id,
            "authResponseData": bytes([0x00]),
            "mrEnclaves": [["mrEnclave": "zz", "hardeningAdvisories": "", "configAdvisories": ""]],
            "mrSigners": [[String: Any]](),
        ]

        assertFails(authEnd, arguments, code: "MISTYSIGN_INVALID_TRUSTED_IDENTITY")
    }

    func testAuthEndWithUnusableEvidenceIsRejected() {
        _ = invoke(authBeginRequestData, ["id": id, "responderId": "misty.test:443"])

        assertFails(authEnd, arguments(for: id, mrSigners: [Self.mrSignerEntry()]),
                    code: "MISTYSIGN_ATTESTATION_FAILED")
        // Failing open here would leave encrypt and decrypt reachable on a
        // channel that was never verified.
        XCTAssertEqual(invoke(isAttested, ["id": id]) as? Bool, false)
    }

    func testDeattestDiscardsThePendingHandshake() {
        _ = invoke(authBeginRequestData, ["id": id, "responderId": "misty.test:443"])
        XCTAssertNil(invoke(deattest, ["id": id]))
        let afterDeattest = assertFails(
            authEnd, arguments(for: id, mrSigners: [Self.mrSignerEntry()]),
            code: "MISTYSIGN_ATTESTATION_FAILED")?.message

        // A session that never began is the control. Both refusals name the same
        // reason only if deattest really dropped the handshake, rather than
        // leaving it open for a stale enclave response to complete.
        let fresh = invoke(create) as? Int ?? 0
        let neverBegun = assertFails(
            authEnd, arguments(for: fresh, mrSigners: [Self.mrSignerEntry()]),
            code: "MISTYSIGN_ATTESTATION_FAILED")?.message
        XCTAssertEqual(afterDeattest, neverBegun)

        _ = invoke(destroy, ["id": fresh])
    }

    func testEveryOperationRejectsAnUnknownHandle() {
        let unknown = ["id": 0x5440]

        assertFails(authBeginRequestData, ["id": 0x5440, "responderId": "misty.test:443"],
                    code: "NATIVE")
        assertFails(encrypt, ["id": 0x5440, "plaintext": bytes([1])], code: "NATIVE")
        assertFails(decrypt, ["id": 0x5440, "messageData": bytes([1])], code: "NATIVE")
        assertFails(deattest, unknown, code: "NATIVE")
        assertFails(isAttested, unknown, code: "NATIVE")
    }

    func testEveryOperationRejectsAHandleHoldingSomethingElse() {
        // Every handle type shares one registry, so an id mix-up arrives as a
        // live entry of the wrong type rather than as a miss.
        guard let foreign = invoke("ClientConfig#create") as? Int else {
            return XCTFail("ClientConfig#create did not hand back a handle")
        }

        assertFails(encrypt, ["id": foreign, "plaintext": bytes([1])], code: "NATIVE")
        assertFails(isAttested, ["id": foreign], code: "NATIVE")

        _ = invoke(destroy, ["id": foreign])
    }

    func testDestroyReleasesTheHandleAndToleratesAnUnknownOne() {
        XCTAssertNil(invoke(destroy, ["id": id]))
        assertFails(isAttested, ["id": id], code: "NATIVE")

        // A double dispose from Dart arrives as two destroys.
        XCTAssertNil(invoke(destroy, ["id": id]))
        XCTAssertNil(invoke(destroy, ["id": 0x5440]))
    }

    func testMissingArgumentsAreRejected() {
        assertFails(authBeginRequestData, ["id": id], code: "NATIVE")
        assertFails(encrypt, ["id": id], code: "NATIVE")
        assertFails(decrypt, ["id": id], code: "NATIVE")
        assertFails(authEnd, ["id": id, "mrEnclaves": [], "mrSigners": []], code: "NATIVE")
        assertFails(destroy, [:], code: "NATIVE")
    }

    private func arguments(for handle: Int, mrSigners: [[String: Any]]) -> [String: Any] {
        [
            "id": handle,
            "authResponseData": bytes([0x00]),
            "mrEnclaves": [[String: Any]](),
            "mrSigners": mrSigners,
        ]
    }

    private static func mrSignerEntry() -> [String: Any] {
        [
            "mrSigner": mrSignerHex,
            "productId": 2,
            "minimumSecurityVersion": 6,
            "hardeningAdvisories": "INTEL-SA-00334,INTEL-SA-00615",
            "configAdvisories": "",
        ]
    }

    /// A signer entry with one field replaced by something unreadable, so each
    /// case differs from the well formed one by exactly the field under test.
    private static func mrSignerEntry(overriding key: String,
                                      with value: Any) -> [String: Any] {
        var entry = mrSignerEntry()
        entry[key] = value
        return entry
    }
}
