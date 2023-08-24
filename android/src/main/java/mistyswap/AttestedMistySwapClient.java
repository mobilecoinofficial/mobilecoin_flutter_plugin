package mistyswap;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;

import com.google.protobuf.ByteString;
import com.mobilecoin.lib.AttestedClient;
import com.mobilecoin.lib.ClientConfig;
import com.mobilecoin.lib.exceptions.AttestationException;
import com.mobilecoin.lib.exceptions.NetworkException;
import com.mobilecoin.lib.LoadBalancer;
import com.mobilecoin.lib.network.NetworkResult;
import com.mobilecoin.lib.network.TransportProtocol;
import com.mobilecoin.lib.network.services.AttestedService;
import com.mobilecoin.lib.network.services.transport.Transport;
import com.mobilecoin.lib.network.services.transport.grpc.GRPCTransport;
import com.mobilecoin.lib.util.NetworkingCall;

import attest.Attest;

@Keep
public class AttestedMistySwapClient extends AttestedClient {

    public AttestedMistySwapClient(@NonNull LoadBalancer loadBalancer, @NonNull ClientConfig.Service serviceConfig, @NonNull TransportProtocol transportProtocol) {
        super(loadBalancer, serviceConfig, transportProtocol);
    }

    @Override
    public synchronized void attest(@NonNull Transport transport) throws AttestationException, NetworkException {
        try {
            final byte[] requestBytes = attestStart(getCurrentServiceUri());
            final AttestedService attestedService = getAPIManager().getAttestedService(transport);
            final ByteString bytes = ByteString.copyFrom(requestBytes);
            final Attest.AuthMessage authMessage = Attest.AuthMessage.newBuilder().setData(bytes).build();
            final Attest.AuthMessage response = attestedService.auth(authMessage);
            attestFinish(response.getData().toByteArray(), getServiceConfig().getVerifier());
        } catch(NetworkException e) {
            attestReset();
            if(e.getResult().getResultCode() == NetworkResult.ResultCode.INTERNAL) {
                throw new AttestationException(e.getResult().getDescription(), e);
            }
            throw e;

        } catch(Exception e) {
            attestReset();
            throw new AttestationException("Unable to attest the Misty Swap connection", e);
        }
    }

    public synchronized byte[] initiateOfframp(@NonNull final byte[] initiateOfframpRequestBytes)
            throws AttestationException, NetworkException {
        NetworkingCall<byte[]> networkingCall =
                new NetworkingCall<>(
                        () -> {
                            final MistyswapOfframp.InitiateOfframpRequest rq =
                                MistyswapOfframp.InitiateOfframpRequest.parseFrom(initiateOfframpRequestBytes);
                            final GRPCMistySwapOfframpClientService mistySwapClientService =
                                    getMistySwapOfframpClientService((GRPCTransport)getNetworkTransport());
                            final Attest.Message encryptedRequest = encryptMessage(rq);
                            final Attest.Message decryptedResponse =
                                    decryptMessage(mistySwapClientService.initiateOfframp(encryptedRequest));
                            return decryptedResponse.getData().toByteArray();
                        }
                );
        try {
            return networkingCall.run();
        } catch (AttestationException | NetworkException | RuntimeException exception) {
            attestReset();
            throw exception;
        } catch (Exception exception) {
            throw new IllegalStateException("BUG: unreachable code", exception);
        }
    }

    public synchronized byte[] forgetOfframp(@NonNull final byte[] forgetOfframpRequestBytes) throws AttestationException, NetworkException {
        NetworkingCall<byte[]> networkingCall =
                new NetworkingCall<>(
                        () -> {
                            final MistyswapOfframp.ForgetOfframpRequest rq =
                                MistyswapOfframp.ForgetOfframpRequest.parseFrom(forgetOfframpRequestBytes);
                            final GRPCMistySwapOfframpClientService mistySwapClientService =
                                    getMistySwapOfframpClientService((GRPCTransport)getNetworkTransport());
                            final Attest.Message encryptedRequest = encryptMessage(rq);
                            final Attest.Message decryptedResponse =
                                    decryptMessage(mistySwapClientService.forgetOfframp(encryptedRequest));
                            return decryptedResponse.getData().toByteArray();
                        }
                );
        try {
            return networkingCall.run();
        } catch (AttestationException | NetworkException | RuntimeException exception) {
            attestReset();
            throw exception;
        } catch (Exception exception) {
            throw new IllegalStateException("BUG: unreachable code", exception);
        }
    }

    public synchronized byte[] getOfframpStatus(@NonNull final byte[] getOfframpStatusRequestBytes) throws AttestationException, NetworkException {
        NetworkingCall<byte[]> networkingCall =
                new NetworkingCall<>(
                        () -> {
                            final MistyswapOfframp.GetOfframpStatusRequest rq =
                                MistyswapOfframp.GetOfframpStatusRequest.parseFrom(getOfframpStatusRequestBytes);
                            final GRPCMistySwapOfframpClientService mistySwapClientService =
                                    getMistySwapOfframpClientService((GRPCTransport)getNetworkTransport());
                            final Attest.Message encryptedRequest = encryptMessage(rq);
                            final Attest.Message decryptedResponse =
                                    decryptMessage(mistySwapClientService.getOfframpStatus(encryptedRequest));
                            return decryptedResponse.getData().toByteArray();
                        }
                );
        try {
            return networkingCall.run();
        } catch (AttestationException | NetworkException | RuntimeException exception) {
            attestReset();
            throw exception;
        } catch (Exception exception) {
            throw new IllegalStateException("BUG: unreachable code", exception);
        }
    }

    public synchronized byte[] getOfframpDebugInfo(@NonNull final byte[] getOfframpDebugInfoRequestBytes) throws AttestationException, NetworkException {
        NetworkingCall<byte[]> networkingCall =
                new NetworkingCall<>(
                        () -> {
                            final MistyswapOfframp.GetOfframpDebugInfoRequest rq =
                                MistyswapOfframp.GetOfframpDebugInfoRequest.parseFrom(getOfframpDebugInfoRequestBytes);
                            final GRPCMistySwapOfframpClientService mistySwapClientService =
                                    getMistySwapOfframpClientService((GRPCTransport)getNetworkTransport());
                            final Attest.Message encryptedRequest = encryptMessage(rq);
                            final Attest.Message decryptedResponse =
                                    decryptMessage(mistySwapClientService.getOfframpDebugInfo(encryptedRequest));
                            return decryptedResponse.getData().toByteArray();
                        }
                );
        try {
            return networkingCall.run();
        } catch (AttestationException | NetworkException | RuntimeException exception) {
            attestReset();
            throw exception;
        } catch (Exception exception) {
            throw new IllegalStateException("BUG: unreachable code", exception);
        }
    }

    public synchronized byte[] setupOnramp(@NonNull final byte[] setupOnrampRequestBytes)
            throws AttestationException, NetworkException {
        NetworkingCall<byte[]> networkingCall =
                new NetworkingCall<>(
                        () -> {
                            final MistyswapOnramp.SetupOnrampRequest rq =
                                MistyswapOnramp.SetupOnrampRequest.parseFrom(setupOnrampRequestBytes);
                            final GRPCMistySwapOnrampClientService mistySwapClientService =
                                    getMistySwapOnrampClientService((GRPCTransport)getNetworkTransport());
                            final Attest.Message encryptedRequest = encryptMessage(rq);
                            final Attest.Message decryptedResponse =
                                    decryptMessage(mistySwapClientService.setupOnramp(encryptedRequest));
                            return decryptedResponse.getData().toByteArray();
                        }
                );
        try {
            return networkingCall.run();
        } catch (AttestationException | NetworkException | RuntimeException exception) {
            attestReset();
            throw exception;
        } catch (Exception exception) {
            throw new IllegalStateException("BUG: unreachable code", exception);
        }
    }

    public synchronized byte[] forgetOnramp(@NonNull final byte[] forgetOnrampRequestBytes) throws AttestationException, NetworkException {
        NetworkingCall<byte[]> networkingCall =
                new NetworkingCall<>(
                        () -> {
                            final MistyswapOnramp.ForgetOnrampRequest rq =
                                MistyswapOnramp.ForgetOnrampRequest.parseFrom(forgetOnrampRequestBytes);
                            final GRPCMistySwapOnrampClientService mistySwapClientService =
                                    getMistySwapOnrampClientService((GRPCTransport)getNetworkTransport());
                            final Attest.Message encryptedRequest = encryptMessage(rq);
                            final Attest.Message decryptedResponse =
                                    decryptMessage(mistySwapClientService.forgetOnramp(encryptedRequest));
                            return decryptedResponse.getData().toByteArray();
                        }
                );
        try {
            return networkingCall.run();
        } catch (AttestationException | NetworkException | RuntimeException exception) {
            attestReset();
            throw exception;
        } catch (Exception exception) {
            throw new IllegalStateException("BUG: unreachable code", exception);
        }
    }

    public synchronized byte[] getOnrampStatus(@NonNull final byte[] getOnrampStatusRequestBytes) throws AttestationException, NetworkException {
        NetworkingCall<byte[]> networkingCall =
                new NetworkingCall<>(
                        () -> {
                            final MistyswapOnramp.GetOnrampStatusRequest rq =
                                MistyswapOnramp.GetOnrampStatusRequest.parseFrom(getOnrampStatusRequestBytes);
                            final GRPCMistySwapOnrampClientService mistySwapClientService =
                                    getMistySwapOnrampClientService((GRPCTransport)getNetworkTransport());
                            final Attest.Message encryptedRequest = encryptMessage(rq);
                            final Attest.Message decryptedResponse =
                                    decryptMessage(mistySwapClientService.getOnrampStatus(encryptedRequest));
                            return decryptedResponse.getData().toByteArray();
                        }
                );
        try {
            return networkingCall.run();
        } catch (AttestationException | NetworkException | RuntimeException exception) {
            attestReset();
            throw exception;
        } catch (Exception exception) {
            throw new IllegalStateException("BUG: unreachable code", exception);
        }
    }

    public synchronized byte[] getOnrampDebugInfo(@NonNull final byte[] getOnrampDebugInfoRequestBytes) throws AttestationException, NetworkException {
        NetworkingCall<byte[]> networkingCall =
                new NetworkingCall<>(
                        () -> {
                            final MistyswapOnramp.GetOnrampDebugInfoRequest rq =
                                MistyswapOnramp.GetOnrampDebugInfoRequest.parseFrom(getOnrampDebugInfoRequestBytes);
                            final GRPCMistySwapOnrampClientService mistySwapClientService =
                                    getMistySwapOnrampClientService((GRPCTransport)getNetworkTransport());
                            final Attest.Message encryptedRequest = encryptMessage(rq);
                            final Attest.Message decryptedResponse =
                                    decryptMessage(mistySwapClientService.getOnrampDebugInfo(encryptedRequest));
                            return decryptedResponse.getData().toByteArray();
                        }
                );
        try {
            return networkingCall.run();
        } catch (AttestationException | NetworkException | RuntimeException exception) {
            attestReset();
            throw exception;
        } catch (Exception exception) {
            throw new IllegalStateException("BUG: unreachable code", exception);
        }
    }

    public synchronized byte[] getInfo() throws AttestationException, NetworkException {
        NetworkingCall<byte[]> networkingCall =
                new NetworkingCall<>(
                        () -> {
                            final GRPCMistySwapCommonClientService mistySwapClientService =
                                    getMistySwapCommonClientService((GRPCTransport)getNetworkTransport());
                            final MistyswapCommon.GetInfoResponse response =
                                    mistySwapClientService.getInfo(com.google.protobuf.Empty.newBuilder().build());
                            return response.toByteArray();
                        }
                );
        try {
            return networkingCall.run();
        } catch (AttestationException | NetworkException | RuntimeException exception) {
            attestReset();
            throw exception;
        } catch (Exception exception) {
            throw new IllegalStateException("BUG: unreachable code", exception);
        }
    }

    static GRPCMistySwapOfframpClientService getMistySwapOfframpClientService(@NonNull GRPCTransport transport) {
        return new GRPCMistySwapOfframpClientService(transport.getManagedChannel());
    }

    static GRPCMistySwapOnrampClientService getMistySwapOnrampClientService(@NonNull GRPCTransport transport) {
        return new GRPCMistySwapOnrampClientService(transport.getManagedChannel());
    }

    static GRPCMistySwapCommonClientService getMistySwapCommonClientService(@NonNull GRPCTransport transport) {
        return new GRPCMistySwapCommonClientService(transport.getManagedChannel());
    }

}
