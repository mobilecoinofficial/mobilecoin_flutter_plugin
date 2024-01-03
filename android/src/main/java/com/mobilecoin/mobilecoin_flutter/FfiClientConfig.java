package com.mobilecoin.mobilecoin_flutter;

import com.mobilecoin.lib.exceptions.AttestationException;
import com.mobilecoin.lib.ClientConfig;
import com.mobilecoin.lib.TrustedIdentities;
import com.mobilecoin.lib.util.Hex;

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
            fogViewService = new ClientConfig.Service().withTrustedIdentities(new TrustedIdentities());
        }
        if (fogLedgerService == null) {
            fogLedgerService = new ClientConfig.Service().withTrustedIdentities(new TrustedIdentities());
        }
        if (fogReportService == null) {
            fogReportService = new ClientConfig.Service().withTrustedIdentities(new TrustedIdentities());
        }
        if (consensusService == null) {
            consensusService = new ClientConfig.Service().withTrustedIdentities(new TrustedIdentities());
        }
        TrustedIdentities fogViewIdentities = fogViewService.getTrustedIdentities();
        fogViewIdentities.addMrEnclaveIdentity(Hex.toByteArray(fogViewMrEnclave), null, hardeningAdvisories);

        TrustedIdentities fogLedgerIdentities = fogLedgerService.getTrustedIdentities();
        fogLedgerIdentities.addMrEnclaveIdentity(Hex.toByteArray(fogLedgerMrEnclave), null,
                hardeningAdvisories);

                TrustedIdentities fogReportIdentities = fogReportService.getTrustedIdentities();
        fogReportIdentities.addMrEnclaveIdentity(Hex.toByteArray(fogReportMrEnclave), null,
                hardeningAdvisories);

                TrustedIdentities consensusIdentities = consensusService.getTrustedIdentities();
        consensusIdentities.addMrEnclaveIdentity(Hex.toByteArray(consensusMrEnclave), null,
                hardeningAdvisories);

        clientConfig.fogView = fogViewService;
        clientConfig.fogLedger = fogLedgerService;
        clientConfig.report = fogReportService;
        clientConfig.consensus = consensusService;
    }
}
