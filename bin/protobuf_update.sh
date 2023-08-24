#!/bin/bash

if ! command -v buf &> /dev/null
then
    echo "buf could not be found. Install with:"
    echo ""
    echo "$ brew install bufbuild/buf/buf"
    echo ""
    echo "then login with"
    echo ""
    echo "$ buf registry login"
    echo ""
    echo "More information about installation can be found in the README.md"
    exit
fi

if ! which protoc &> /dev/null
then
    echo "protoc could not be found. Install with:"
    echo ""
    echo "$ brew install protobuf"
    exit
fi

if ! which protoc-gen-dart &> /dev/null
then
    echo "protoc-gen-dart could not be found. Install with:"
    echo ""
    echo "$ ./flutterw pub global activate protoc_plugin"
    exit
fi

PROTOC_VERSION="20.0.1"
if ! ./flutterw pub global list | grep "protoc_plugin $PROTOC_VERSION" &> /dev/null
then
    echo "protoc_plugin needs to be on version $PROTOC_VERSION."
    echo "please upgrade with:"
    echo ""
    echo "$ ./flutterw pub global activate protoc_plugin $PROTOC_VERSION"
fi

echo "generating..."

# only remove the files that are in source control to not mess with local env
if [ -d "lib/protobufs/generated" ]; then
  git rm -r lib/protobufs/src/protobufs/generated &> /dev/null
  mkdir -p lib/protobufs/src/protobufs/generated
fi

# generate files from buf.build
buf generate buf.build/mobilecoin-inc/misty-swap

protoc --proto_path=lib/src/protobufs/ \
 --dart_out=grpc:lib/src/protobufs/generated/ \
 lib/src/protobufs/google/protobuf/empty.proto

# add the files back to source control
git add lib/src/protobufs/generated/

echo "done"
