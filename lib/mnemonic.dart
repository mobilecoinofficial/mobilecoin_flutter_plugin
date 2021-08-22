import 'dart:typed_data';
import 'package:mobilecoin_flutter/mobilecoin.dart';

class Mnemonic {
  static Future<String> fromBip39Entropy(
    Uint8List entropy,
  ) async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .mnemonicFromBip39Entropy(
      entropy,
    );
  }

  static Future<Uint8List> toBip39Entropy(
    String mnemonicPhrase,
  ) async {
    return await MobileCoinFlutterPluginChannelApi.instance
        .mnemonicToBip39Entropy(
      mnemonicPhrase,
    );
  }

  static Future<List<String>> allWords() async {
    String allWordsAsString =
        await MobileCoinFlutterPluginChannelApi.instance.mnemonicAllWords();
    return allWordsAsString.split(',');
  }
}
