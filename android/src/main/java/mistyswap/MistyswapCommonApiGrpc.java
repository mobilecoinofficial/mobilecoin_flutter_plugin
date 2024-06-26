// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

package mistyswap;

import static io.grpc.MethodDescriptor.generateFullMethodName;

/**
 */
@javax.annotation.Generated(
    value = "by gRPC proto compiler (version 1.55.1)",
    comments = "Source: mistyswap_common.proto")
@io.grpc.stub.annotations.GrpcGenerated
public final class MistyswapCommonApiGrpc {

  private MistyswapCommonApiGrpc() {}

  public static final String SERVICE_NAME = "mistyswap_common.MistyswapCommonApi";

  // Static method descriptors that strictly reflect the proto.
  private static volatile io.grpc.MethodDescriptor<com.google.protobuf.Empty,
      mistyswap.MistyswapCommon.GetInfoResponse> getGetInfoMethod;

  @io.grpc.stub.annotations.RpcMethod(
      fullMethodName = SERVICE_NAME + '/' + "GetInfo",
      requestType = com.google.protobuf.Empty.class,
      responseType = mistyswap.MistyswapCommon.GetInfoResponse.class,
      methodType = io.grpc.MethodDescriptor.MethodType.UNARY)
  public static io.grpc.MethodDescriptor<com.google.protobuf.Empty,
      mistyswap.MistyswapCommon.GetInfoResponse> getGetInfoMethod() {
    io.grpc.MethodDescriptor<com.google.protobuf.Empty, mistyswap.MistyswapCommon.GetInfoResponse> getGetInfoMethod;
    if ((getGetInfoMethod = MistyswapCommonApiGrpc.getGetInfoMethod) == null) {
      synchronized (MistyswapCommonApiGrpc.class) {
        if ((getGetInfoMethod = MistyswapCommonApiGrpc.getGetInfoMethod) == null) {
          MistyswapCommonApiGrpc.getGetInfoMethod = getGetInfoMethod =
              io.grpc.MethodDescriptor.<com.google.protobuf.Empty, mistyswap.MistyswapCommon.GetInfoResponse>newBuilder()
              .setType(io.grpc.MethodDescriptor.MethodType.UNARY)
              .setFullMethodName(generateFullMethodName(SERVICE_NAME, "GetInfo"))
              .setSampledToLocalTracing(true)
              .setRequestMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  com.google.protobuf.Empty.getDefaultInstance()))
              .setResponseMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  mistyswap.MistyswapCommon.GetInfoResponse.getDefaultInstance()))
              .build();
        }
      }
    }
    return getGetInfoMethod;
  }

  /**
   * Creates a new async stub that supports all call types for the service
   */
  public static MistyswapCommonApiStub newStub(io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<MistyswapCommonApiStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<MistyswapCommonApiStub>() {
        @java.lang.Override
        public MistyswapCommonApiStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new MistyswapCommonApiStub(channel, callOptions);
        }
      };
    return MistyswapCommonApiStub.newStub(factory, channel);
  }

  /**
   * Creates a new blocking-style stub that supports unary and streaming output calls on the service
   */
  public static MistyswapCommonApiBlockingStub newBlockingStub(
      io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<MistyswapCommonApiBlockingStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<MistyswapCommonApiBlockingStub>() {
        @java.lang.Override
        public MistyswapCommonApiBlockingStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new MistyswapCommonApiBlockingStub(channel, callOptions);
        }
      };
    return MistyswapCommonApiBlockingStub.newStub(factory, channel);
  }

  /**
   * Creates a new ListenableFuture-style stub that supports unary calls on the service
   */
  public static MistyswapCommonApiFutureStub newFutureStub(
      io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<MistyswapCommonApiFutureStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<MistyswapCommonApiFutureStub>() {
        @java.lang.Override
        public MistyswapCommonApiFutureStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new MistyswapCommonApiFutureStub(channel, callOptions);
        }
      };
    return MistyswapCommonApiFutureStub.newStub(factory, channel);
  }

  /**
   */
  public interface AsyncService {

    /**
     * <pre>
     *&#47; Get information about this mistyswap instance.
     * </pre>
     */
    default void getInfo(com.google.protobuf.Empty request,
        io.grpc.stub.StreamObserver<mistyswap.MistyswapCommon.GetInfoResponse> responseObserver) {
      io.grpc.stub.ServerCalls.asyncUnimplementedUnaryCall(getGetInfoMethod(), responseObserver);
    }
  }

  /**
   * Base class for the server implementation of the service MistyswapCommonApi.
   */
  public static abstract class MistyswapCommonApiImplBase
      implements io.grpc.BindableService, AsyncService {

    @java.lang.Override public final io.grpc.ServerServiceDefinition bindService() {
      return MistyswapCommonApiGrpc.bindService(this);
    }
  }

  /**
   * A stub to allow clients to do asynchronous rpc calls to service MistyswapCommonApi.
   */
  public static final class MistyswapCommonApiStub
      extends io.grpc.stub.AbstractAsyncStub<MistyswapCommonApiStub> {
    private MistyswapCommonApiStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected MistyswapCommonApiStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new MistyswapCommonApiStub(channel, callOptions);
    }

    /**
     * <pre>
     *&#47; Get information about this mistyswap instance.
     * </pre>
     */
    public void getInfo(com.google.protobuf.Empty request,
        io.grpc.stub.StreamObserver<mistyswap.MistyswapCommon.GetInfoResponse> responseObserver) {
      io.grpc.stub.ClientCalls.asyncUnaryCall(
          getChannel().newCall(getGetInfoMethod(), getCallOptions()), request, responseObserver);
    }
  }

  /**
   * A stub to allow clients to do synchronous rpc calls to service MistyswapCommonApi.
   */
  public static final class MistyswapCommonApiBlockingStub
      extends io.grpc.stub.AbstractBlockingStub<MistyswapCommonApiBlockingStub> {
    private MistyswapCommonApiBlockingStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected MistyswapCommonApiBlockingStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new MistyswapCommonApiBlockingStub(channel, callOptions);
    }

    /**
     * <pre>
     *&#47; Get information about this mistyswap instance.
     * </pre>
     */
    public mistyswap.MistyswapCommon.GetInfoResponse getInfo(com.google.protobuf.Empty request) {
      return io.grpc.stub.ClientCalls.blockingUnaryCall(
          getChannel(), getGetInfoMethod(), getCallOptions(), request);
    }
  }

  /**
   * A stub to allow clients to do ListenableFuture-style rpc calls to service MistyswapCommonApi.
   */
  public static final class MistyswapCommonApiFutureStub
      extends io.grpc.stub.AbstractFutureStub<MistyswapCommonApiFutureStub> {
    private MistyswapCommonApiFutureStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected MistyswapCommonApiFutureStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new MistyswapCommonApiFutureStub(channel, callOptions);
    }

    /**
     * <pre>
     *&#47; Get information about this mistyswap instance.
     * </pre>
     */
    public com.google.common.util.concurrent.ListenableFuture<mistyswap.MistyswapCommon.GetInfoResponse> getInfo(
        com.google.protobuf.Empty request) {
      return io.grpc.stub.ClientCalls.futureUnaryCall(
          getChannel().newCall(getGetInfoMethod(), getCallOptions()), request);
    }
  }

  private static final int METHODID_GET_INFO = 0;

  private static final class MethodHandlers<Req, Resp> implements
      io.grpc.stub.ServerCalls.UnaryMethod<Req, Resp>,
      io.grpc.stub.ServerCalls.ServerStreamingMethod<Req, Resp>,
      io.grpc.stub.ServerCalls.ClientStreamingMethod<Req, Resp>,
      io.grpc.stub.ServerCalls.BidiStreamingMethod<Req, Resp> {
    private final AsyncService serviceImpl;
    private final int methodId;

    MethodHandlers(AsyncService serviceImpl, int methodId) {
      this.serviceImpl = serviceImpl;
      this.methodId = methodId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("unchecked")
    public void invoke(Req request, io.grpc.stub.StreamObserver<Resp> responseObserver) {
      switch (methodId) {
        case METHODID_GET_INFO:
          serviceImpl.getInfo((com.google.protobuf.Empty) request,
              (io.grpc.stub.StreamObserver<mistyswap.MistyswapCommon.GetInfoResponse>) responseObserver);
          break;
        default:
          throw new AssertionError();
      }
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("unchecked")
    public io.grpc.stub.StreamObserver<Req> invoke(
        io.grpc.stub.StreamObserver<Resp> responseObserver) {
      switch (methodId) {
        default:
          throw new AssertionError();
      }
    }
  }

  public static final io.grpc.ServerServiceDefinition bindService(AsyncService service) {
    return io.grpc.ServerServiceDefinition.builder(getServiceDescriptor())
        .addMethod(
          getGetInfoMethod(),
          io.grpc.stub.ServerCalls.asyncUnaryCall(
            new MethodHandlers<
              com.google.protobuf.Empty,
              mistyswap.MistyswapCommon.GetInfoResponse>(
                service, METHODID_GET_INFO)))
        .build();
  }

  private static volatile io.grpc.ServiceDescriptor serviceDescriptor;

  public static io.grpc.ServiceDescriptor getServiceDescriptor() {
    io.grpc.ServiceDescriptor result = serviceDescriptor;
    if (result == null) {
      synchronized (MistyswapCommonApiGrpc.class) {
        result = serviceDescriptor;
        if (result == null) {
          serviceDescriptor = result = io.grpc.ServiceDescriptor.newBuilder(SERVICE_NAME)
              .addMethod(getGetInfoMethod())
              .build();
        }
      }
    }
    return result;
  }
}
