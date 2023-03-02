package com.mobilecoin.mobilecoin_flutter;

import com.mobilecoin.lib.exceptions.AttestationException;
import com.mobilecoin.lib.ClientConfig;
import com.mobilecoin.lib.Verifier;
import com.mobilecoin.lib.util.Hex;

import java.util.List;

public class FfiClientConfig {
    private FfiClientConfig() {}

    public static int create() {
        ClientConfig config = new ClientConfig();
        final int hashCode = config.hashCode();
        ObjectStorage.addObject(hashCode, config);
        return hashCode;
    }

    public static void addServiceConfig(Integer clientConfigId, String fogViewMrEnclave,
            String fogLedgerMrEnclave, String fogReportMrEnclave, String consensusMrEnclave,
            String[] hardeningAdvisories) throws AttestationException {
        ClientConfig clientConfig = (ClientConfig) ObjectStorage.objectForKey(clientConfigId);
        ClientConfig.Service fogViewService = clientConfig.fogView;
        ClientConfig.Service fogLedgerService = clientConfig.fogLedger;
        ClientConfig.Service fogReportService = clientConfig.report;
        ClientConfig.Service consensusService = clientConfig.consensus;
        if (fogViewService == null) {
            fogViewService = new ClientConfig.Service().withVerifier(new Verifier());
        }
        if (fogLedgerService == null) {
            fogLedgerService = new ClientConfig.Service().withVerifier(new Verifier());
        }
        if (fogReportService == null) {
            fogReportService = new ClientConfig.Service().withVerifier(new Verifier());
        }
        if (consensusService == null) {
            consensusService = new ClientConfig.Service().withVerifier(new Verifier());
        }
        Verifier fogViewVerifier = fogViewService.getVerifier();
        fogViewVerifier.withMrEnclave(Hex.toByteArray(fogViewMrEnclave), null, hardeningAdvisories);

        Verifier fogLedgerVerifier = fogLedgerService.getVerifier();
        fogLedgerVerifier.withMrEnclave(Hex.toByteArray(fogLedgerMrEnclave), null,
                hardeningAdvisories);

        Verifier fogReportVerifier = fogReportService.getVerifier();
        fogReportVerifier.withMrEnclave(Hex.toByteArray(fogReportMrEnclave), null,
                hardeningAdvisories);

        Verifier consensusVerifier = consensusService.getVerifier();
        consensusVerifier.withMrEnclave(Hex.toByteArray(consensusMrEnclave), null,
                hardeningAdvisories);

        clientConfig.fogView = fogViewService;
        clientConfig.fogLedger = fogLedgerService;
        clientConfig.report = fogReportService;
        clientConfig.consensus = consensusService;
    }
}
