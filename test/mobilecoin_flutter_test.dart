import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobilecoin_flutter/src/mobilecoin_flutter_plugin_channel_api.dart';

void main() {
  const MethodChannel channel = MethodChannel('mobilecoin_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (_) async => '42');
  });

  test("constructs channel api", () async {
    expect(MobileCoinFlutterPluginChannelApi.instance, isNotNull);
  });
}
