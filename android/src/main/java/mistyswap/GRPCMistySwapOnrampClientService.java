package mistyswap;

import androidx.annotation.NonNull;

import com.mobilecoin.lib.exceptions.NetworkException;
import com.mobilecoin.lib.network.NetworkResult;
import com.mobilecoin.lib.network.grpc.AuthInterceptor;
import com.mobilecoin.lib.network.grpc.CookieInterceptor;
import com.mobilecoin.lib.network.grpc.GRPCStatusResponse;
import com.mobilecoin.lib.network.services.grpc.GRPCService;

import java.util.concurrent.Executors;

import attest.Attest;
import io.grpc.ManagedChannel;
import io.grpc.StatusRuntimeException;
import mistyswap.MistyswapOnramp;
import mistyswap.MistyswapOnrampApiGrpc;

public class GRPCMistySwapOnrampClientService
        extends GRPCService<MistyswapOnrampApiGrpc.MistyswapOnrampApiBlockingStub> {

    public GRPCMistySwapOnrampClientService(@NonNull ManagedChannel managedChannel) {
        super(managedChannel, new CookieInterceptor(), new AuthInterceptor(), Executors.newSingleThreadExecutor());
    }

    @NonNull
    protected MistyswapOnrampApiGrpc.MistyswapOnrampApiBlockingStub newBlockingStub(@NonNull ManagedChannel managedChannel) {
        return MistyswapOnrampApiGrpc.newBlockingStub(managedChannel);
    }

    @NonNull
    public Attest.Message setupOnramp(@NonNull Attest.Message message) throws NetworkException {
        try {
            return getApiBlockingStub().setupOnramp(message);
        } catch(StatusRuntimeException e) {
            throw new NetworkException(new NetworkResult(new GRPCStatusResponse(e.getStatus())));
        }
    }

    @NonNull
    public Attest.Message forgetOnramp(@NonNull Attest.Message message) throws NetworkException {
        try {
            return getApiBlockingStub().forgetOnramp(message);
        } catch(StatusRuntimeException e) {
            throw new NetworkException(new NetworkResult(new GRPCStatusResponse(e.getStatus())));
        }
    }

    @NonNull
    public Attest.Message getOnrampStatus(@NonNull Attest.Message message) throws NetworkException {
        try {
            return getApiBlockingStub().getOnrampStatus(message);
        } catch(StatusRuntimeException e) {
            throw new NetworkException(new NetworkResult(new GRPCStatusResponse(e.getStatus())));
        }
    }

    @NonNull
    public Attest.Message getOnrampDebugInfo(@NonNull Attest.Message message) throws NetworkException {
        try {
            return getApiBlockingStub().getOnrampDebugInfo(message);
        } catch(StatusRuntimeException e) {
            throw new NetworkException(new NetworkResult(new GRPCStatusResponse(e.getStatus())));
        }
    }

}
