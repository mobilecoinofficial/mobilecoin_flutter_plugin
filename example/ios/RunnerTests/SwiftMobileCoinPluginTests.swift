// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

import Flutter
import XCTest

/// Covers the dispatch seam every command reaches Dart through.
final class SwiftMobileCoinPluginTests: PluginChannelTestCase {

    func testAnUnknownMethodIsRejected() {
        // A method the Dart side spells wrong has to come back as an error
        // rather than as a silent nil the caller reads as a result.
        assertFails("MistysignAttestedSession#attest", code: "NATIVE")
        assertFails("", code: "NATIVE")
    }

    func testMnemonicWordListIsRoutedThroughTheChannel() {
        let words = (invoke("Mnemonic#allWords") as? String)?.split(separator: ",") ?? []

        XCTAssertEqual(words.count, 2048)
        XCTAssertEqual(words.first, "abandon")
        XCTAssertEqual(words.last, "zoo")
    }

    func testMnemonicRoundTripsBip39Entropy() {
        let entropy = bytes([UInt8](repeating: 0, count: 32))

        guard let phrase = invoke("Mnemonic#fromBip39Entropy",
                                  ["bip39Entropy": entropy]) as? String else {
            return XCTFail("Mnemonic#fromBip39Entropy did not hand back a phrase")
        }

        XCTAssertEqual(phrase.split(separator: " ").count, 24)
        XCTAssertEqual(invoke("Mnemonic#toBip39Entropy",
                              ["mnemonicPhrase": phrase]) as? Data, entropy.data)
    }

    func testAMalformedMnemonicIsRejected() {
        assertFails("Mnemonic#toBip39Entropy", ["mnemonicPhrase": "not a mnemonic"],
                    code: "NATIVE")
    }
}
