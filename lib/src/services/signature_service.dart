import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;

class SignatureService {
  static String createSignature(
      Map<String, dynamic> queryParameters, String passphrase) {
    var md5 = crypto.md5;
    String parameters = '';
    for (var element in queryParameters.keys) {
      if (element.contains("url")) {
        parameters +=
            '${'$element=${Uri.encodeComponent(queryParameters[element])}'}&';
      } else {
        parameters += '${'$element=' + queryParameters[element]}&';
      }
    }
    parameters += "passphrase=$passphrase";
    return md5.convert(Utf8Encoder().convert(parameters)).toString();
  }
}
