// Copyright (c) 2021-2026 MobileCoin. All rights reserved.

import Flutter
import XCTest

import mobilecoin_flutter

/// Drives the plugin through the same public entry point the Dart side reaches,
/// so routing, argument decoding and error mapping are all covered by whatever
/// the assertion looks at.
class PluginChannelTestCase: XCTestCase {

    private var plugin = SwiftMobileCoinPlugin()

    override func setUp() {
        super.setUp()
        plugin = SwiftMobileCoinPlugin()
    }

    /// Returns what the command replied with, having checked it replied once.
    /// A second reply on one call raises a Flutter assertion at runtime, and a
    /// missing reply leaves the Dart future hanging forever.
    func invoke(_ method: String,
                _ arguments: [String: Any] = [:],
                file: StaticString = #filePath,
                line: UInt = #line) -> Any? {
        var replies: [Any?] = []
        plugin.handle(FlutterMethodCall(methodName: method, arguments: arguments)) {
            replies.append($0)
        }

        XCTAssertEqual(replies.count, 1, "\(method) replied \(replies.count) times",
                       file: file, line: line)
        return replies.first ?? nil
    }

    /// Asserts the command failed and returns the code Dart would match on.
    @discardableResult
    func assertFails(_ method: String,
                     _ arguments: [String: Any] = [:],
                     code expected: String,
                     file: StaticString = #filePath,
                     line: UInt = #line) -> FlutterError? {
        let reply = invoke(method, arguments, file: file, line: line)
        guard let error = reply as? FlutterError else {
            XCTFail("\(method) should have failed with \(expected)", file: file, line: line)
            return nil
        }

        XCTAssertEqual(error.code, expected, file: file, line: line)
        return error
    }

    func bytes(_ values: [UInt8]) -> FlutterStandardTypedData {
        FlutterStandardTypedData(bytes: Data(values))
    }
}
