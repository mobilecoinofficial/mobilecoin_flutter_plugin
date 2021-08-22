import Flutter
import UIKit
import MobileCoin

enum PluginError: Error {
    case invalidArguments
    case invalidCall
    case notFound
    case unimplemented
}

protocol Command {
    func execute(args: [String: Any], result: @escaping FlutterResult) throws
}

class CommandFactory {
    class func commandForCall(_ method: String) throws -> Command  {
        switch method {
        case "AccountKey#fromBip39Entropy":
            return FfiAccountKey.FromBip39Entropy()
        case "AccountKey#getPublicAddress":
            return FfiAccountKey.GetPublicAddress()
        case "MobileCoinClient#create":
            return FfiMobileCoinClient.Create()
        case "MobileCoinClient#getBalance":
            return FfiMobileCoinClient.GetBalance()
        case "MobileCoinClient#getAccountActivity":
            return FfiMobileCoinClient.GetAccountActivity()
        case "MobileCoinClient#setAuthorization":
            return FfiMobileCoinClient.SetAuthorization()
        case "MobileCoinClient#sendFunds":
            return FfiMobileCoinClient.SendFunds()
        case "PublicAddress#fromBytes":
            return FfiPublicAddress.FromBytes()
        case "PublicAddress#toByteArray":
            return FfiPublicAddress.ToByteArray()
        case "PrintableWrapper#toB58String":
            return FfiPrintableWrapper.ToB58String()
        case "PrintableWrapper#fromB58String":
            return FfiPrintableWrapper.FromB58String()
        case "PrintableWrapper#fromPublicAddress":
            return FfiPrintableWrapper.FromPublicAddress()
        case "PrintableWrapper#getPublicAddress":
            return FfiPrintableWrapper.GetPublicAddress()
        case "PrintableWrapper#hasPublicAddress":
            return FfiPrintableWrapper.HasPublicAddress()
        case "PrintableWrapper#fromTransferPayload":
            return FfiPrintableWrapper.FromTransferPayload()
        case "PrintableWrapper#getTransferPayload":
            return FfiPrintableWrapper.GetTransferPayload()
        case "PrintableWrapper#hasTransferPayload":
            return FfiPrintableWrapper.HasTransferPayload()
        case "PrintableWrapper#getPaymentRequest":
            return FfiPrintableWrapper.GetPaymentRequest()
        case "PrintableWrapper#hasPaymentRequest":
            return FfiPrintableWrapper.HasPaymentRequest()
        case "TransferPayload#getBip39Entropy":
            return FfiTransferPayload.GetBip39Entropy()
        case "TransferPayload#getMemo":
            return FfiTransferPayload.GetMemo()
        case "TransferPayload#getPublicKey":
            return FfiTransferPayload.GetPublicKey()
        case "PaymentRequest#getMemo":
            return FfiPaymentRequest.GetMemo()
        case "PaymentRequest#getValue":
            return FfiPaymentRequest.GetValue()
        case "PaymentRequest#getPublicAddress":
            return FfiPaymentRequest.GetPublicAddress()
        case "Mnemonic#fromBip39Entropy":
            return FfiMnemonic.FromBip39Entropy()
        case "Mnemonic#toBip39Entropy":
            return FfiMnemonic.ToBip39Entropy()
        case "Mnemonic#allWords":
            return FfiMnemonic.AllWords()
        default:
            throw PluginError.invalidCall
        }
    }
}

struct ObjectStorage {
    private static var managedObjects = [Int: Any]()
    private static let lockQueue = DispatchQueue(label: "com.mobilecoin.plugin", attributes: .concurrent)
    
    static func objectForKey(_ key: Int) -> Any? {
        return lockQueue.sync {
            managedObjects[key]
        }
    }
    
    static func addObject(_ obj: Any, forKey key: Int) {
        lockQueue.sync(flags: .barrier) {
            managedObjects[key] = obj
        }
    }
}

public class SwiftMobileCoinPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "mobilecoin_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftMobileCoinPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    private func executeNativeMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) throws {
        let args = call.arguments as! [String: Any]
        let command = try CommandFactory.commandForCall(call.method)
        try command.execute(args: args, result: result)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        do {
            try executeNativeMethodCall(call, result:result)
        } catch {
            result(FlutterError.init(code:"NATIVE", message:error.localizedDescription, details: nil))
        }
    }
}
