//
//  FfiClientConfig.swift
//  mobilecoin_flutter
//
//  Created by Adam Mork on 2/20/23.
//

import Flutter
import Foundation
import MobileCoin

struct ClientConfig {
    let id = UUID()
    var fogView: [ServiceMrEnclave] = []
    var fogLedger: [ServiceMrEnclave] = []
    var fogReport: [ServiceMrEnclave] = []
    var consensus: [ServiceMrEnclave] = []
    var mistyswap: [ServiceMrEnclave] = []

    public static func create() -> Int {
        var client = ClientConfig() 
        let hash: Int = client.hashValue
        ObjectStorage.addObject(client, forKey: hash)
        return hash
    }

    public mutating func addServiceConfig(
        fogViewMrEnclave: String,
        fogLedgerMrEnclave: String,
        fogReportMrEnclave: String,
        consensusMrEnclave: String,
        hardeningAdvisories: [String],
        configAdvisories: [String] = [],
        mistyswapMrEnclave: String? = nil
    ) {
        self.fogView.append(
            ServiceMrEnclave(
                mrEnclave: fogViewMrEnclave,
                hardeningAdvisories: hardeningAdvisories,
                configAdvisories: configAdvisories
            )
        )

        self.fogLedger.append(
            ServiceMrEnclave(
                mrEnclave: fogLedgerMrEnclave,
                hardeningAdvisories: hardeningAdvisories,
                configAdvisories: configAdvisories
            )
        )

        self.fogReport.append(
            ServiceMrEnclave(
                mrEnclave: fogReportMrEnclave,
                hardeningAdvisories: hardeningAdvisories,
                configAdvisories: configAdvisories
            )
        )

        self.consensus.append(
            ServiceMrEnclave(
                mrEnclave: consensusMrEnclave,
                hardeningAdvisories: hardeningAdvisories,
                configAdvisories: configAdvisories
            )
        )
        
        if let mistyswapMrEnclave = mistyswapMrEnclave {
            self.mistyswap.append(
                ServiceMrEnclave(
                    mrEnclave: mistyswapMrEnclave,
                    hardeningAdvisories: hardeningAdvisories,
                    configAdvisories: configAdvisories
                )
            )
        }
    }

    public func save() {
        ObjectStorage.addObject(self, forKey: self.hashValue)
    }

    var consensusMrEnclaves: [Attestation.MrEnclave] {
        compactMapToAttestations(service: consensus)
    }

    var fogViewMrEnclaves: [Attestation.MrEnclave] {
        compactMapToAttestations(service: fogView)
    }

    var fogLedgerMrEnclaves: [Attestation.MrEnclave] {
        compactMapToAttestations(service: fogLedger)
    }

    var fogReportMrEnclaves: [Attestation.MrEnclave] {
        compactMapToAttestations(service: fogReport)
    }

    var mistyswapMrEnclaves: [Attestation.MrEnclave] {
        compactMapToAttestations(service: mistyswap)
    }

    private func compactMapToAttestations(service: [ServiceMrEnclave]) -> [Attestation.MrEnclave] {
        service.compactMap({ serviceMrEnclave in
            guard 
                let mrEnclave = HexEncoding.data(fromHexEncodedString: serviceMrEnclave.mrEnclave)
            else {
                return nil
            }

            let configAdvisories = serviceMrEnclave.configAdvisories 
            let hardeningAdvisories = serviceMrEnclave.hardeningAdvisories 
            return try? Attestation.MrEnclave.make(
                mrEnclave: mrEnclave,
                allowedConfigAdvisories: configAdvisories,
                allowedHardeningAdvisories: hardeningAdvisories 
            ).get()
        })
    }
}

extension ClientConfig: Hashable {
    static func == (lhs: ClientConfig, rhs: ClientConfig) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ClientConfig: CustomStringConvertible {
    var description: String {
        """
        fogView: \(fogView.count)
        fogLedger: \(fogLedger.count)
        fogReport: \(fogReport.count)
        consensus: \(consensus.count)
        mistyswap: \(mistyswap.count)
        """
    }
}

struct ServiceMrEnclave {
    var mrEnclave: String
    var hardeningAdvisories: [String] = []
    var configAdvisories: [String] = []
}


struct FfiClientConfig {
    static var fogViewMrEnclaveKey = "fogViewMrEnclave"
    static var fogLedgerMrEnclaveKey = "fogLedgerMrEnclave"
    static var fogReportMrEnclaveKey = "fogReportMrEnclave"
    static var consensusMrEnclaveKey = "consensusMrEnclave"
    static var mistyswapMrEnclaveKey = "mistyswapMrEnclave"
    static var hardeningAdvisoriesKey = "hardeningAdvisories"

    struct Create: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            let hash: Int = ClientConfig.create()
            result(hash)
        }
    }

    struct AddServiceConfig: Command {
        func execute(args: [String : Any], result: @escaping FlutterResult) throws {
            guard 
                let clientConfigId = args["clientConfigId"] as? Int,
                var clientConfig = ObjectStorage.objectForKey(clientConfigId) as? ClientConfig,
                let fogViewMrEnclave = args["fogViewMrEnclave"] as? String,
                let fogLedgerMrEnclave = args["fogLedgerMrEnclave"] as? String,
                let fogReportMrEnclave = args["fogReportMrEnclave"] as? String,
                let consensusMrEnclave = args["consensusMrEnclave"] as? String,
                let hardeningAdvisoriesString = args["hardeningAdvisories"] as? String
            else {
                result(FlutterError(code: "NATIVE", message: "AddServiceConfig", details: "parsing arguments"))
                throw PluginError.invalidArguments
            }

            let hardeningAdvisories = hardeningAdvisoriesString.split(separator: ",").map({ 
                String($0)
            })

            clientConfig.addServiceConfig(
                fogViewMrEnclave: fogViewMrEnclave,
                fogLedgerMrEnclave: fogLedgerMrEnclave,
                fogReportMrEnclave: fogReportMrEnclave,
                consensusMrEnclave: consensusMrEnclave,
                hardeningAdvisories: hardeningAdvisories,
                mistyswapMrEnclave: (args["mistyswapMrEnclave"] as? String)
            )

            clientConfig.save()
            result(clientConfig.hashValue)
        }
    }
}
