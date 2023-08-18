package mistyswap;

import static io.grpc.MethodDescriptor.generateFullMethodName;

/**
 */
@javax.annotation.Generated(
    value = "by gRPC proto compiler (version 1.55.1)",
    comments = "Source: mistyswap_offramp.proto")
@io.grpc.stub.annotations.GrpcGenerated
public final class MistyswapOfframpApiGrpc {

  private MistyswapOfframpApiGrpc() {}

  public static final String SERVICE_NAME = "mistyswap_offramp.MistyswapOfframpApi";

  // Static method descriptors that strictly reflect the proto.
  private static volatile io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getInitiateOfframpMethod;

  @io.grpc.stub.annotations.RpcMethod(
      fullMethodName = SERVICE_NAME + '/' + "InitiateOfframp",
      requestType = attest.Attest.Message.class,
      responseType = attest.Attest.Message.class,
      methodType = io.grpc.MethodDescriptor.MethodType.UNARY)
  public static io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getInitiateOfframpMethod() {
    io.grpc.MethodDescriptor<attest.Attest.Message, attest.Attest.Message> getInitiateOfframpMethod;
    if ((getInitiateOfframpMethod = MistyswapOfframpApiGrpc.getInitiateOfframpMethod) == null) {
      synchronized (MistyswapOfframpApiGrpc.class) {
        if ((getInitiateOfframpMethod = MistyswapOfframpApiGrpc.getInitiateOfframpMethod) == null) {
          MistyswapOfframpApiGrpc.getInitiateOfframpMethod = getInitiateOfframpMethod =
              io.grpc.MethodDescriptor.<attest.Attest.Message, attest.Attest.Message>newBuilder()
              .setType(io.grpc.MethodDescriptor.MethodType.UNARY)
              .setFullMethodName(generateFullMethodName(SERVICE_NAME, "InitiateOfframp"))
              .setSampledToLocalTracing(true)
              .setRequestMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .setResponseMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .build();
        }
      }
    }
    return getInitiateOfframpMethod;
  }

  private static volatile io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getForgetOfframpMethod;

  @io.grpc.stub.annotations.RpcMethod(
      fullMethodName = SERVICE_NAME + '/' + "ForgetOfframp",
      requestType = attest.Attest.Message.class,
      responseType = attest.Attest.Message.class,
      methodType = io.grpc.MethodDescriptor.MethodType.UNARY)
  public static io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getForgetOfframpMethod() {
    io.grpc.MethodDescriptor<attest.Attest.Message, attest.Attest.Message> getForgetOfframpMethod;
    if ((getForgetOfframpMethod = MistyswapOfframpApiGrpc.getForgetOfframpMethod) == null) {
      synchronized (MistyswapOfframpApiGrpc.class) {
        if ((getForgetOfframpMethod = MistyswapOfframpApiGrpc.getForgetOfframpMethod) == null) {
          MistyswapOfframpApiGrpc.getForgetOfframpMethod = getForgetOfframpMethod =
              io.grpc.MethodDescriptor.<attest.Attest.Message, attest.Attest.Message>newBuilder()
              .setType(io.grpc.MethodDescriptor.MethodType.UNARY)
              .setFullMethodName(generateFullMethodName(SERVICE_NAME, "ForgetOfframp"))
              .setSampledToLocalTracing(true)
              .setRequestMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .setResponseMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .build();
        }
      }
    }
    return getForgetOfframpMethod;
  }

  private static volatile io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getGetOfframpStatusMethod;

  @io.grpc.stub.annotations.RpcMethod(
      fullMethodName = SERVICE_NAME + '/' + "GetOfframpStatus",
      requestType = attest.Attest.Message.class,
      responseType = attest.Attest.Message.class,
      methodType = io.grpc.MethodDescriptor.MethodType.UNARY)
  public static io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getGetOfframpStatusMethod() {
    io.grpc.MethodDescriptor<attest.Attest.Message, attest.Attest.Message> getGetOfframpStatusMethod;
    if ((getGetOfframpStatusMethod = MistyswapOfframpApiGrpc.getGetOfframpStatusMethod) == null) {
      synchronized (MistyswapOfframpApiGrpc.class) {
        if ((getGetOfframpStatusMethod = MistyswapOfframpApiGrpc.getGetOfframpStatusMethod) == null) {
          MistyswapOfframpApiGrpc.getGetOfframpStatusMethod = getGetOfframpStatusMethod =
              io.grpc.MethodDescriptor.<attest.Attest.Message, attest.Attest.Message>newBuilder()
              .setType(io.grpc.MethodDescriptor.MethodType.UNARY)
              .setFullMethodName(generateFullMethodName(SERVICE_NAME, "GetOfframpStatus"))
              .setSampledToLocalTracing(true)
              .setRequestMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .setResponseMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .build();
        }
      }
    }
    return getGetOfframpStatusMethod;
  }

  private static volatile io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getGetOfframpDebugInfoMethod;

  @io.grpc.stub.annotations.RpcMethod(
      fullMethodName = SERVICE_NAME + '/' + "GetOfframpDebugInfo",
      requestType = attest.Attest.Message.class,
      responseType = attest.Attest.Message.class,
      methodType = io.grpc.MethodDescriptor.MethodType.UNARY)
  public static io.grpc.MethodDescriptor<attest.Attest.Message,
      attest.Attest.Message> getGetOfframpDebugInfoMethod() {
    io.grpc.MethodDescriptor<attest.Attest.Message, attest.Attest.Message> getGetOfframpDebugInfoMethod;
    if ((getGetOfframpDebugInfoMethod = MistyswapOfframpApiGrpc.getGetOfframpDebugInfoMethod) == null) {
      synchronized (MistyswapOfframpApiGrpc.class) {
        if ((getGetOfframpDebugInfoMethod = MistyswapOfframpApiGrpc.getGetOfframpDebugInfoMethod) == null) {
          MistyswapOfframpApiGrpc.getGetOfframpDebugInfoMethod = getGetOfframpDebugInfoMethod =
              io.grpc.MethodDescriptor.<attest.Attest.Message, attest.Attest.Message>newBuilder()
              .setType(io.grpc.MethodDescriptor.MethodType.UNARY)
              .setFullMethodName(generateFullMethodName(SERVICE_NAME, "GetOfframpDebugInfo"))
              .setSampledToLocalTracing(true)
              .setRequestMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .setResponseMarshaller(io.grpc.protobuf.lite.ProtoLiteUtils.marshaller(
                  attest.Attest.Message.getDefaultInstance()))
              .build();
        }
      }
    }
    return getGetOfframpDebugInfoMethod;
  }

  /**
   * Creates a new async stub that supports all call types for the service
   */
  public static MistyswapOfframpApiStub newStub(io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<MistyswapOfframpApiStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<MistyswapOfframpApiStub>() {
        @java.lang.Override
        public MistyswapOfframpApiStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new MistyswapOfframpApiStub(channel, callOptions);
        }
      };
    return MistyswapOfframpApiStub.newStub(factory, channel);
  }

  /**
   * Creates a new blocking-style stub that supports unary and streaming output calls on the service
   */
  public static MistyswapOfframpApiBlockingStub newBlockingStub(
      io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<MistyswapOfframpApiBlockingStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<MistyswapOfframpApiBlockingStub>() {
        @java.lang.Override
        public MistyswapOfframpApiBlockingStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new MistyswapOfframpApiBlockingStub(channel, callOptions);
        }
      };
    return MistyswapOfframpApiBlockingStub.newStub(factory, channel);
  }

  /**
   * Creates a new ListenableFuture-style stub that supports unary calls on the service
   */
  public static MistyswapOfframpApiFutureStub newFutureStub(
      io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<MistyswapOfframpApiFutureStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<MistyswapOfframpApiFutureStub>() {
        @java.lang.Override
        public MistyswapOfframpApiFutureStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new MistyswapOfframpApiFutureStub(channel, callOptions);
        }
      };
    return MistyswapOfframpApiFutureStub.newStub(factory, channel);
  }

  /**
   */
  public interface AsyncService {

    /**
     * <pre>
     *&#47; Initiate (or pick up a previously initiated) offramp.
     * / Input should be an encrypted InitiateOfframpRequest, output is an encrypted InitiateOfframpResponse.
     * </pre>
     */
    default void initiateOfframp(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ServerCalls.asyncUnimplementedUnaryCall(getInitiateOfframpMethod(), responseObserver);
    }

    /**
     * <pre>
     *&#47; Forget an offramp.
     * / Input should be an encrypted ForgetOfframpRequest, output is an encrypted ForgetOfframpResponse.
     * </pre>
     */
    default void forgetOfframp(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ServerCalls.asyncUnimplementedUnaryCall(getForgetOfframpMethod(), responseObserver);
    }

    /**
     * <pre>
     *&#47; Get the status of an offramp.
     * / Input should be an encrypted GetOfframpStatusRequest, output is an encrypted GetOfframpStatusResponse.
     * </pre>
     */
    default void getOfframpStatus(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ServerCalls.asyncUnimplementedUnaryCall(getGetOfframpStatusMethod(), responseObserver);
    }

    /**
     * <pre>
     *&#47; Get debug info.
     * / Input should be an encrypted GetOfframpDebugInfoRequest, output is an encrypted GetOfframpDebugInfoResponse.
     * </pre>
     */
    default void getOfframpDebugInfo(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ServerCalls.asyncUnimplementedUnaryCall(getGetOfframpDebugInfoMethod(), responseObserver);
    }
  }

  /**
   * Base class for the server implementation of the service MistyswapOfframpApi.
   */
  public static abstract class MistyswapOfframpApiImplBase
      implements io.grpc.BindableService, AsyncService {

    @java.lang.Override public final io.grpc.ServerServiceDefinition bindService() {
      return MistyswapOfframpApiGrpc.bindService(this);
    }
  }

  /**
   * A stub to allow clients to do asynchronous rpc calls to service MistyswapOfframpApi.
   */
  public static final class MistyswapOfframpApiStub
      extends io.grpc.stub.AbstractAsyncStub<MistyswapOfframpApiStub> {
    private MistyswapOfframpApiStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected MistyswapOfframpApiStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new MistyswapOfframpApiStub(channel, callOptions);
    }

    /**
     * <pre>
     *&#47; Initiate (or pick up a previously initiated) offramp.
     * / Input should be an encrypted InitiateOfframpRequest, output is an encrypted InitiateOfframpResponse.
     * </pre>
     */
    public void initiateOfframp(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ClientCalls.asyncUnaryCall(
          getChannel().newCall(getInitiateOfframpMethod(), getCallOptions()), request, responseObserver);
    }

    /**
     * <pre>
     *&#47; Forget an offramp.
     * / Input should be an encrypted ForgetOfframpRequest, output is an encrypted ForgetOfframpResponse.
     * </pre>
     */
    public void forgetOfframp(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ClientCalls.asyncUnaryCall(
          getChannel().newCall(getForgetOfframpMethod(), getCallOptions()), request, responseObserver);
    }

    /**
     * <pre>
     *&#47; Get the status of an offramp.
     * / Input should be an encrypted GetOfframpStatusRequest, output is an encrypted GetOfframpStatusResponse.
     * </pre>
     */
    public void getOfframpStatus(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ClientCalls.asyncUnaryCall(
          getChannel().newCall(getGetOfframpStatusMethod(), getCallOptions()), request, responseObserver);
    }

    /**
     * <pre>
     *&#47; Get debug info.
     * / Input should be an encrypted GetOfframpDebugInfoRequest, output is an encrypted GetOfframpDebugInfoResponse.
     * </pre>
     */
    public void getOfframpDebugInfo(attest.Attest.Message request,
        io.grpc.stub.StreamObserver<attest.Attest.Message> responseObserver) {
      io.grpc.stub.ClientCalls.asyncUnaryCall(
          getChannel().newCall(getGetOfframpDebugInfoMethod(), getCallOptions()), request, responseObserver);
    }
  }

  /**
   * A stub to allow clients to do synchronous rpc calls to service MistyswapOfframpApi.
   */
  public static final class MistyswapOfframpApiBlockingStub
      extends io.grpc.stub.AbstractBlockingStub<MistyswapOfframpApiBlockingStub> {
    private MistyswapOfframpApiBlockingStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected MistyswapOfframpApiBlockingStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new MistyswapOfframpApiBlockingStub(channel, callOptions);
    }

    /**
     * <pre>
     *&#47; Initiate (or pick up a previously initiated) offramp.
     * / Input should be an encrypted InitiateOfframpRequest, output is an encrypted InitiateOfframpResponse.
     * </pre>
     */
    public attest.Attest.Message initiateOfframp(attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.blockingUnaryCall(
          getChannel(), getInitiateOfframpMethod(), getCallOptions(), request);
    }

    /**
     * <pre>
     *&#47; Forget an offramp.
     * / Input should be an encrypted ForgetOfframpRequest, output is an encrypted ForgetOfframpResponse.
     * </pre>
     */
    public attest.Attest.Message forgetOfframp(attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.blockingUnaryCall(
          getChannel(), getForgetOfframpMethod(), getCallOptions(), request);
    }

    /**
     * <pre>
     *&#47; Get the status of an offramp.
     * / Input should be an encrypted GetOfframpStatusRequest, output is an encrypted GetOfframpStatusResponse.
     * </pre>
     */
    public attest.Attest.Message getOfframpStatus(attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.blockingUnaryCall(
          getChannel(), getGetOfframpStatusMethod(), getCallOptions(), request);
    }

    /**
     * <pre>
     *&#47; Get debug info.
     * / Input should be an encrypted GetOfframpDebugInfoRequest, output is an encrypted GetOfframpDebugInfoResponse.
     * </pre>
     */
    public attest.Attest.Message getOfframpDebugInfo(attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.blockingUnaryCall(
          getChannel(), getGetOfframpDebugInfoMethod(), getCallOptions(), request);
    }
  }

  /**
   * A stub to allow clients to do ListenableFuture-style rpc calls to service MistyswapOfframpApi.
   */
  public static final class MistyswapOfframpApiFutureStub
      extends io.grpc.stub.AbstractFutureStub<MistyswapOfframpApiFutureStub> {
    private MistyswapOfframpApiFutureStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected MistyswapOfframpApiFutureStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new MistyswapOfframpApiFutureStub(channel, callOptions);
    }

    /**
     * <pre>
     *&#47; Initiate (or pick up a previously initiated) offramp.
     * / Input should be an encrypted InitiateOfframpRequest, output is an encrypted InitiateOfframpResponse.
     * </pre>
     */
    public com.google.common.util.concurrent.ListenableFuture<attest.Attest.Message> initiateOfframp(
        attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.futureUnaryCall(
          getChannel().newCall(getInitiateOfframpMethod(), getCallOptions()), request);
    }

    /**
     * <pre>
     *&#47; Forget an offramp.
     * / Input should be an encrypted ForgetOfframpRequest, output is an encrypted ForgetOfframpResponse.
     * </pre>
     */
    public com.google.common.util.concurrent.ListenableFuture<attest.Attest.Message> forgetOfframp(
        attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.futureUnaryCall(
          getChannel().newCall(getForgetOfframpMethod(), getCallOptions()), request);
    }

    /**
     * <pre>
     *&#47; Get the status of an offramp.
     * / Input should be an encrypted GetOfframpStatusRequest, output is an encrypted GetOfframpStatusResponse.
     * </pre>
     */
    public com.google.common.util.concurrent.ListenableFuture<attest.Attest.Message> getOfframpStatus(
        attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.futureUnaryCall(
          getChannel().newCall(getGetOfframpStatusMethod(), getCallOptions()), request);
    }

    /**
     * <pre>
     *&#47; Get debug info.
     * / Input should be an encrypted GetOfframpDebugInfoRequest, output is an encrypted GetOfframpDebugInfoResponse.
     * </pre>
     */
    public com.google.common.util.concurrent.ListenableFuture<attest.Attest.Message> getOfframpDebugInfo(
        attest.Attest.Message request) {
      return io.grpc.stub.ClientCalls.futureUnaryCall(
          getChannel().newCall(getGetOfframpDebugInfoMethod(), getCallOptions()), request);
    }
  }

  private static final int METHODID_INITIATE_OFFRAMP = 0;
  private static final int METHODID_FORGET_OFFRAMP = 1;
  private static final int METHODID_GET_OFFRAMP_STATUS = 2;
  private static final int METHODID_GET_OFFRAMP_DEBUG_INFO = 3;

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
        case METHODID_INITIATE_OFFRAMP:
          serviceImpl.initiateOfframp((attest.Attest.Message) request,
              (io.grpc.stub.StreamObserver<attest.Attest.Message>) responseObserver);
          break;
        case METHODID_FORGET_OFFRAMP:
          serviceImpl.forgetOfframp((attest.Attest.Message) request,
              (io.grpc.stub.StreamObserver<attest.Attest.Message>) responseObserver);
          break;
        case METHODID_GET_OFFRAMP_STATUS:
          serviceImpl.getOfframpStatus((attest.Attest.Message) request,
              (io.grpc.stub.StreamObserver<attest.Attest.Message>) responseObserver);
          break;
        case METHODID_GET_OFFRAMP_DEBUG_INFO:
          serviceImpl.getOfframpDebugInfo((attest.Attest.Message) request,
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
          getInitiateOfframpMethod(),
          io.grpc.stub.ServerCalls.asyncUnaryCall(
            new MethodHandlers<
              attest.Attest.Message,
              attest.Attest.Message>(
                service, METHODID_INITIATE_OFFRAMP)))
        .addMethod(
          getForgetOfframpMethod(),
          io.grpc.stub.ServerCalls.asyncUnaryCall(
            new MethodHandlers<
              attest.Attest.Message,
              attest.Attest.Message>(
                service, METHODID_FORGET_OFFRAMP)))
        .addMethod(
          getGetOfframpStatusMethod(),
          io.grpc.stub.ServerCalls.asyncUnaryCall(
            new MethodHandlers<
              attest.Attest.Message,
              attest.Attest.Message>(
                service, METHODID_GET_OFFRAMP_STATUS)))
        .addMethod(
          getGetOfframpDebugInfoMethod(),
          io.grpc.stub.ServerCalls.asyncUnaryCall(
            new MethodHandlers<
              attest.Attest.Message,
              attest.Attest.Message>(
                service, METHODID_GET_OFFRAMP_DEBUG_INFO)))
        .build();
  }

  private static volatile io.grpc.ServiceDescriptor serviceDescriptor;

  public static io.grpc.ServiceDescriptor getServiceDescriptor() {
    io.grpc.ServiceDescriptor result = serviceDescriptor;
    if (result == null) {
      synchronized (MistyswapOfframpApiGrpc.class) {
        result = serviceDescriptor;
        if (result == null) {
          serviceDescriptor = result = io.grpc.ServiceDescriptor.newBuilder(SERVICE_NAME)
              .addMethod(getInitiateOfframpMethod())
              .addMethod(getForgetOfframpMethod())
              .addMethod(getGetOfframpStatusMethod())
              .addMethod(getGetOfframpDebugInfoMethod())
              .build();
        }
      }
    }
    return result;
  }
}
