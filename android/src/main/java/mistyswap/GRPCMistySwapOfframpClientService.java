// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

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

public class GRPCMistySwapOfframpClientService
        extends GRPCService<MistyswapOfframpApiGrpc.MistyswapOfframpApiBlockingStub> {

    public GRPCMistySwapOfframpClientService(@NonNull ManagedChannel managedChannel) {
        super(managedChannel, new CookieInterceptor(), new AuthInterceptor(), Executors.newSingleThreadExecutor());
    }

    @NonNull
    protected MistyswapOfframpApiGrpc.MistyswapOfframpApiBlockingStub newBlockingStub(@NonNull ManagedChannel managedChannel) {
        return MistyswapOfframpApiGrpc.newBlockingStub(managedChannel);
    }

    @NonNull
    public Attest.Message initiateOfframp(@NonNull Attest.Message message) throws NetworkException {
        try {
            return getApiBlockingStub().initiateOfframp(message);
        } catch(StatusRuntimeException e) {
            throw new NetworkException(new NetworkResult(new GRPCStatusResponse(e.getStatus())));
        }
    }

    @NonNull
    public Attest.Message forgetOfframp(@NonNull Attest.Message message) throws NetworkException {
        try {
            return getApiBlockingStub().forgetOfframp(message);
        } catch(StatusRuntimeException e) {
            throw new NetworkException(new NetworkResult(new GRPCStatusResponse(e.getStatus())));
        }
    }

    @NonNull
    public Attest.Message getOfframpStatus(@NonNull Attest.Message message) throws NetworkException {
        try {
            return getApiBlockingStub().getOfframpStatus(message);
        } catch(StatusRuntimeException e) {
            throw new NetworkException(new NetworkResult(new GRPCStatusResponse(e.getStatus())));
        }
    }

    @NonNull
    public Attest.Message getOfframpDebugInfo(@NonNull Attest.Message message) throws NetworkException {
        try {
            return getApiBlockingStub().getOfframpDebugInfo(message);
        } catch(StatusRuntimeException e) {
            throw new NetworkException(new NetworkResult(new GRPCStatusResponse(e.getStatus())));
        }
    }

}
