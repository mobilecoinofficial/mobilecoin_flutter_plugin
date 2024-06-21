// Copyright (c) 2021-2024 MobileCoin. All rights reserved.

package mistyswap;

import static io.grpc.MethodDescriptor.generateFullMethodName;

/**
 */
@javax.annotation.Generated(
    value = "by gRPC proto compiler (version 1.55.1)",
    comments = "Source: mistyswap_onramp.proto")
@io.grpc.stub.annotations.GrpcGenerated
public final class MistyswapOnrampApiGrpc {

  private MistyswapOnrampApiGrpc() {}

  public static final String SERVICE_NAME = "mistyswap_onramp.MistyswapOnrampApi";

  // Static method descriptors that strictly reflect the proto.
  private static volatile io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getSetupOnrampMethod;

  @io.grpc.stub.annotations.RpcMethod(
      fullMethodName = SERVICE_NAME + '/' + "SetupOnramp",
      requestType = attest.Attest.Message.class,
      responseType = attest.Attest.Message.class,
      methodType = io.grpc.MethodDescriptor.MethodType.UNARY)
  public static io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getSetupOnrampMethod() {
    io.grpc.MethodDescriptor<attest.Attest.Message, attest.Attest.Message> getSetupOnrampMethod;
    if ((getSetupOnrampMethod = MistyswapOnrampApiGrpc.getSetupOnrampMethod) == null) {
      synchronized (MistyswapOnrampApiGrpc.class) {
        if ((getSetupOnrampMethod = MistyswapOnrampApiGrpc.getSetupOnrampMethod) == null) {
          MistyswapOnrampApiGrpc.getSetupOnrampMethod = getSetupOnrampMethod =
              io.grpc.MethodDescriptor.<attest.Attest.Message, attest.Attest.Message>newBuilder()
              .setType(io.grpc.MethodDescriptor.MethodType.UNARY)
              .setFullMethodName(generateFullMethodName(SERVICE_NAME, "SetupOnramp"))
              .setSampledToLocalTracing(true)
              .setRequestMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .setResponseMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .build();
        }
      }
    }
    return getSetupOnrampMethod;
  }

  private static volatile io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getForgetOnrampMethod;

  @io.grpc.stub.annotations.RpcMethod(
      fullMethodName = SERVICE_NAME + '/' + "ForgetOnramp",
      requestType = attest.Attest.Message.class,
      responseType = attest.Attest.Message.class,
      methodType = io.grpc.MethodDescriptor.MethodType.UNARY)
  public static io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getForgetOnrampMethod() {
    io.grpc.MethodDescriptor<attest.Attest.Message, attest.Attest.Message> getForgetOnrampMethod;
    if ((getForgetOnrampMethod = MistyswapOnrampApiGrpc.getForgetOnrampMethod) == null) {
      synchronized (MistyswapOnrampApiGrpc.class) {
        if ((getForgetOnrampMethod = MistyswapOnrampApiGrpc.getForgetOnrampMethod) == null) {
          MistyswapOnrampApiGrpc.getForgetOnrampMethod = getForgetOnrampMethod =
              io.grpc.MethodDescriptor.<attest.Attest.Message, attest.Attest.Message>newBuilder()
              .setType(io.grpc.MethodDescriptor.MethodType.UNARY)
              .setFullMethodName(generateFullMethodName(SERVICE_NAME, "ForgetOnramp"))
              .setSampledToLocalTracing(true)
              .setRequestMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .setResponseMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .build();
        }
      }
    }
    return getForgetOnrampMethod;
  }

  private static volatile io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getGetOnrampStatusMethod;

  @io.grpc.stub.annotations.RpcMethod(
      fullMethodName = SERVICE_NAME + '/' + "GetOnrampStatus",
      requestType = attest.Attest.Message.class,
      responseType = attest.Attest.Message.class,
      methodType = io.grpc.MethodDescriptor.MethodType.UNARY)
  public static io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getGetOnrampStatusMethod() {
    io.grpc.MethodDescriptor<attest.Attest.Message, attest.Attest.Message> getGetOnrampStatusMethod;
    if ((getGetOnrampStatusMethod = MistyswapOnrampApiGrpc.getGetOnrampStatusMethod) == null) {
      synchronized (MistyswapOnrampApiGrpc.class) {
        if ((getGetOnrampStatusMethod = MistyswapOnrampApiGrpc.getGetOnrampStatusMethod) == null) {
          MistyswapOnrampApiGrpc.getGetOnrampStatusMethod = getGetOnrampStatusMethod =
              io.grpc.MethodDescriptor.<attest.Attest.Message, attest.Attest.Message>newBuilder()
              .setType(io.grpc.MethodDescriptor.MethodType.UNARY)
              .setFullMethodName(generateFullMethodName(SERVICE_NAME, "GetOnrampStatus"))
              .setSampledToLocalTracing(true)
              .setRequestMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .setResponseMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .build();
        }
      }
    }
    return getGetOnrampStatusMethod;
  }

  private static volatile io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getGetOnrampDebugInfoMethod;

  @io.grpc.stub.annotations.RpcMethod(
      fullMethodName = SERVICE_NAME + '/' + "GetOnrampDebugInfo",
      requestType = attest.Attest.Message.class,
      responseType = attest.Attest.Message.class,
      methodType = io.grpc.MethodDescriptor.MethodType.UNARY)
  public static io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getGetOnrampDebugInfoMethod() {
    io.grpc.MethodDescriptor<attest.Attest.Message, attest.Attest.Message> getGetOnrampDebugInfoMethod;
    if ((getGetOnrampDebugInfoMethod = MistyswapOnrampApiGrpc.getGetOnrampDebugInfoMethod) == null) {
      synchronized (MistyswapOnrampApiGrpc.class) {
        if ((getGetOnrampDebugInfoMethod = MistyswapOnrampApiGrpc.getGetOnrampDebugInfoMethod) == null) {
          MistyswapOnrampApiGrpc.getGetOnrampDebugInfoMethod = getGetOnrampDebugInfoMethod =
              io.grpc.MethodDescriptor.<attest.Attest.Message, attest.Attest.Message>newBuilder()
              .setType(io.grpc.MethodDescriptor.MethodType.UNARY)
              .setFullMethodName(generateFullMethodName(SERVICE_NAME, "GetOnrampDebugInfo"))
              .setSampledToLocalTracing(true)
              .setRequestMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .setResponseMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .build();
        }
      }
    }
    return getGetOnrampDebugInfoMethod;
  }

  /**
   * Creates a new async stub that supports all call types for the service
   */
  public static MistyswapOnrampApiStub newStub(io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<MistyswapOnrampApiStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<MistyswapOnrampApiStub>() {
        @java.lang.Override
        public MistyswapOnrampApiStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new MistyswapOnrampApiStub(channel, callOptions);
        }
      };
    return MistyswapOnrampApiStub.newStub(factory, channel);
  }

  /**
   * Creates a new blocking-style stub that supports unary and streaming output calls on the service
   */
  public static MistyswapOnrampApiBlockingStub newBlockingStub(
      io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<MistyswapOnrampApiBlockingStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<MistyswapOnrampApiBlockingStub>() {
        @java.lang.Override
        public MistyswapOnrampApiBlockingStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new MistyswapOnrampApiBlockingStub(channel, callOptions);
        }
      };
    return MistyswapOnrampApiBlockingStub.newStub(factory, channel);
  }

  /**
   * Creates a new ListenableFuture-style stub that supports unary calls on the service
   */
  public static MistyswapOnrampApiFutureStub newFutureStub(
      io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<MistyswapOnrampApiFutureStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<MistyswapOnrampApiFutureStub>() {
        @java.lang.Override
        public MistyswapOnrampApiFutureStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new MistyswapOnrampApiFutureStub(channel, callOptions);
        }
      };
    return MistyswapOnrampApiFutureStub.newStub(factory, channel);
  }

  /**
   */
  public interface AsyncService {

    /**
     * <pre>
     *&#47; Setup onramping (or check if it is already setup).
     * / Input should be an encrypted SetupOnrampRequest, output is an encrypted SetupOnrampResponse.
     * </pre>
     */
    default void setupOnramp(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ServerCalls.asyncUnimplementedUnaryCall(getSetupOnrampMethod(), responseObserver);
    }

    /**
     * <pre>
     *&#47; Forget an onramp.
     * / Input should be an encrypted ForgetOnrampRequest, output is an encrypted ForgetOnrampResponse.
     * </pre>
     */
    default void forgetOnramp(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ServerCalls.asyncUnimplementedUnaryCall(getForgetOnrampMethod(), responseObserver);
    }

    /**
     * <pre>
     *&#47; Get the status of an onramp.
     * / Input should be an encrypted GetOnrampStatusRequest, output is an encrypted GetOnrampStatusResponse.
     * </pre>
     */
    default void getOnrampStatus(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ServerCalls.asyncUnimplementedUnaryCall(getGetOnrampStatusMethod(), responseObserver);
    }

    /**
     * <pre>
     *&#47; Get debug info.
     * / Input should be an encrypted GetOnrampDebugInfoRequest, output is an encrypted GetOnrampDebugInfoResponse.
     * </pre>
     */
    default void getOnrampDebugInfo(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ServerCalls.asyncUnimplementedUnaryCall(getGetOnrampDebugInfoMethod(), responseObserver);
    }
  }

  /**
   * Base class for the server implementation of the service MistyswapOnrampApi.
   */
  public static abstract class MistyswapOnrampApiImplBase
      implements io.grpc.BindableService, AsyncService {

    @java.lang.Override public final io.grpc.ServerServiceDefinition bindService() {
      return MistyswapOnrampApiGrpc.bindService(this);
    }
  }

  /**
   * A stub to allow clients to do asynchronous rpc calls to service MistyswapOnrampApi.
   */
  public static final class MistyswapOnrampApiStub
      extends io.grpc.stub.AbstractAsyncStub<MistyswapOnrampApiStub> {
    private MistyswapOnrampApiStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected MistyswapOnrampApiStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new MistyswapOnrampApiStub(channel, callOptions);
    }

    /**
     * <pre>
     *&#47; Setup onramping (or check if it is already setup).
     * / Input should be an encrypted SetupOnrampRequest, output is an encrypted SetupOnrampResponse.
     * </pre>
     */
    public void setupOnramp(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ClientCalls.asyncUnaryCall(
          getChannel().newCall(getSetupOnrampMethod(), getCallOptions()), request, responseObserver);
    }

    /**
     * <pre>
     *&#47; Forget an onramp.
     * / Input should be an encrypted ForgetOnrampRequest, output is an encrypted ForgetOnrampResponse.
     * </pre>
     */
    public void forgetOnramp(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ClientCalls.asyncUnaryCall(
          getChannel().newCall(getForgetOnrampMethod(), getCallOptions()), request, responseObserver);
    }

    /**
     * <pre>
     *&#47; Get the status of an onramp.
     * / Input should be an encrypted GetOnrampStatusRequest, output is an encrypted GetOnrampStatusResponse.
     * </pre>
     */
    public void getOnrampStatus(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ClientCalls.asyncUnaryCall(
          getChannel().newCall(getGetOnrampStatusMethod(), getCallOptions()), request, responseObserver);
    }

    /**
     * <pre>
     *&#47; Get debug info.
     * / Input should be an encrypted GetOnrampDebugInfoRequest, output is an encrypted GetOnrampDebugInfoResponse.
     * </pre>
     */
    public void getOnrampDebugInfo(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ClientCalls.asyncUnaryCall(
          getChannel().newCall(getGetOnrampDebugInfoMethod(), getCallOptions()), request, responseObserver);
    }
  }

  /**
   * A stub to allow clients to do synchronous rpc calls to service MistyswapOnrampApi.
   */
  public static final class MistyswapOnrampApiBlockingStub
      extends io.grpc.stub.AbstractBlockingStub<MistyswapOnrampApiBlockingStub> {
    private MistyswapOnrampApiBlockingStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected MistyswapOnrampApiBlockingStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new MistyswapOnrampApiBlockingStub(channel, callOptions);
    }

    /**
     * <pre>
     *&#47; Setup onramping (or check if it is already setup).
     * / Input should be an encrypted SetupOnrampRequest, output is an encrypted SetupOnrampResponse.
     * </pre>
     */
    public attest.Attest.Message setupOnramp(attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.blockingUnaryCall(
          getChannel(), getSetupOnrampMethod(), getCallOptions(), request);
    }

    /**
     * <pre>
     *&#47; Forget an onramp.
     * / Input should be an encrypted ForgetOnrampRequest, output is an encrypted ForgetOnrampResponse.
     * </pre>
     */
    public attest.Attest.Message forgetOnramp(attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.blockingUnaryCall(
          getChannel(), getForgetOnrampMethod(), getCallOptions(), request);
    }

    /**
     * <pre>
     *&#47; Get the status of an onramp.
     * / Input should be an encrypted GetOnrampStatusRequest, output is an encrypted GetOnrampStatusResponse.
     * </pre>
     */
    public attest.Attest.Message getOnrampStatus(attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.blockingUnaryCall(
          getChannel(), getGetOnrampStatusMethod(), getCallOptions(), request);
    }

    /**
     * <pre>
     *&#47; Get debug info.
     * / Input should be an encrypted GetOnrampDebugInfoRequest, output is an encrypted GetOnrampDebugInfoResponse.
     * </pre>
     */
    public attest.Attest.Message getOnrampDebugInfo(attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.blockingUnaryCall(
          getChannel(), getGetOnrampDebugInfoMethod(), getCallOptions(), request);
    }
  }

  /**
   * A stub to allow clients to do ListenableFuture-style rpc calls to service MistyswapOnrampApi.
   */
  public static final class MistyswapOnrampApiFutureStub
      extends io.grpc.stub.AbstractFutureStub<MistyswapOnrampApiFutureStub> {
    private MistyswapOnrampApiFutureStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected MistyswapOnrampApiFutureStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new MistyswapOnrampApiFutureStub(channel, callOptions);
    }

    /**
     * <pre>
     *&#47; Setup onramping (or check if it is already setup).
     * / Input should be an encrypted SetupOnrampRequest, output is an encrypted SetupOnrampResponse.
     * </pre>
     */
    public com.google.common.util.concurrent.ListenableFuture<attest.Attest.Message> setupOnramp(
        attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.futureUnaryCall(
          getChannel().newCall(getSetupOnrampMethod(), getCallOptions()), request);
    }

    /**
     * <pre>
     *&#47; Forget an onramp.
     * / Input should be an encrypted ForgetOnrampRequest, output is an encrypted ForgetOnrampResponse.
     * </pre>
     */
    public com.google.common.util.concurrent.ListenableFuture<attest.Attest.Message> forgetOnramp(
        attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.futureUnaryCall(
          getChannel().newCall(getForgetOnrampMethod(), getCallOptions()), request);
    }

    /**
     * <pre>
     *&#47; Get the status of an onramp.
     * / Input should be an encrypted GetOnrampStatusRequest, output is an encrypted GetOnrampStatusResponse.
     * </pre>
     */
    public com.google.common.util.concurrent.ListenableFuture<attest.Attest.Message> getOnrampStatus(
        attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.futureUnaryCall(
          getChannel().newCall(getGetOnrampStatusMethod(), getCallOptions()), request);
    }

    /**
     * <pre>
     *&#47; Get debug info.
     * / Input should be an encrypted GetOnrampDebugInfoRequest, output is an encrypted GetOnrampDebugInfoResponse.
     * </pre>
     */
    public com.google.common.util.concurrent.ListenableFuture<attest.Attest.Message> getOnrampDebugInfo(
        attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.futureUnaryCall(
          getChannel().newCall(getGetOnrampDebugInfoMethod(), getCallOptions()), request);
    }
  }

  private static final int METHODID_SETUP_ONRAMP = 0;
  private static final int METHODID_FORGET_ONRAMP = 1;
  private static final int METHODID_GET_ONRAMP_STATUS = 2;
  private static final int METHODID_GET_ONRAMP_DEBUG_INFO = 3;

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
        case METHODID_SETUP_ONRAMP:
          serviceImpl.setupOnramp((attest.Attest.Message) request,
              (io.grpc.stub.StreamObserver<attest.Attest.Message>) responseObserver);
          break;
        case METHODID_FORGET_ONRAMP:
          serviceImpl.forgetOnramp((attest.Attest.Message) request,
              (io.grpc.stub.StreamObserver<attest.Attest.Message>) responseObserver);
          break;
        case METHODID_GET_ONRAMP_STATUS:
          serviceImpl.getOnrampStatus((attest.Attest.Message) request,
              (io.grpc.stub.StreamObserver<attest.Attest.Message>) responseObserver);
          break;
        case METHODID_GET_ONRAMP_DEBUG_INFO:
          serviceImpl.getOnrampDebugInfo((attest.Attest.Message) request,
              (io.grpc.stub.StreamObserver<attest.Attest.Message>) responseObserver);
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
          getSetupOnrampMethod(),
          io.grpc.stub.ServerCalls.asyncUnaryCall(
            new MethodHandlers<
              attest.Attest.Message,
              attest.Attest.Message>(
                service, METHODID_SETUP_ONRAMP)))
        .addMethod(
          getForgetOnrampMethod(),
          io.grpc.stub.ServerCalls.asyncUnaryCall(
            new MethodHandlers<
              attest.Attest.Message,
              attest.Attest.Message>(
                service, METHODID_FORGET_ONRAMP)))
        .addMethod(
          getGetOnrampStatusMethod(),
          io.grpc.stub.ServerCalls.asyncUnaryCall(
            new MethodHandlers<
              attest.Attest.Message,
              attest.Attest.Message>(
                service, METHODID_GET_ONRAMP_STATUS)))
        .addMethod(
          getGetOnrampDebugInfoMethod(),
          io.grpc.stub.ServerCalls.asyncUnaryCall(
            new MethodHandlers<
              attest.Attest.Message,
              attest.Attest.Message>(
                service, METHODID_GET_ONRAMP_DEBUG_INFO)))
        .build();
  }

  private static volatile io.grpc.ServiceDescriptor serviceDescriptor;

  public static io.grpc.ServiceDescriptor getServiceDescriptor() {
    io.grpc.ServiceDescriptor result = serviceDescriptor;
    if (result == null) {
      synchronized (MistyswapOnrampApiGrpc.class) {
        result = serviceDescriptor;
        if (result == null) {
          serviceDescriptor = result = io.grpc.ServiceDescriptor.newBuilder(SERVICE_NAME)
              .addMethod(getSetupOnrampMethod())
              .addMethod(getForgetOnrampMethod())
              .addMethod(getGetOnrampStatusMethod())
              .addMethod(getGetOnrampDebugInfoMethod())
              .build();
        }
      }
    }
    return result;
  }
}
