package mistyswap;

import androidx.annotation.NonNull;

import com.mobilecoin.lib.exceptions.NetworkException;
import com.mobilecoin.lib.network.NetworkResult;
import com.mobilecoin.lib.network.grpc.AuthInterceptor;
import com.mobilecoin.lib.network.grpc.CookieInterceptor;
import com.mobilecoin.lib.network.grpc.GRPCStatusResponse;
import com.mobilecoin.lib.network.services.grpc.GRPCService;

import java.util.concurrent.Executors;

import io.grpc.ManagedChannel;
import io.grpc.StatusRuntimeException;

public class GRPCMistySwapCommonClientService
        extends GRPCService<MistyswapCommonApiGrpc.MistyswapCommonApiBlockingStub> {

    public GRPCMistySwapCommonClientService(@NonNull ManagedChannel managedChannel) {
        super(managedChannel, new CookieInterceptor(), new AuthInterceptor(), Executors.newSingleThreadExecutor());
    }

    @NonNull
    protected MistyswapCommonApiGrpc.MistyswapCommonApiBlockingStub newBlockingStub(@NonNull ManagedChannel managedChannel) {
        return MistyswapCommonApiGrpc.newBlockingStub(managedChannel);
    }

    @NonNull
    public MistyswapCommon.GetInfoResponse getInfo(@NonNull com.google.protobuf.Empty message) throws NetworkException {
        try {
            return getApiBlockingStub().getInfo(message);
        } catch(StatusRuntimeException e) {
            throw new NetworkException(new NetworkResult(new GRPCStatusResponse(e.getStatus())));
        }
    }

}
