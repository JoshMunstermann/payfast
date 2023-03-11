import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;

class SignatureService {
  static String createSignature(
      Map<String, dynamic> queryParameters, String passphrase) {
    String parameters = '';
    for (var element in queryParameters.keys) {
      var qp = queryParameters[element];
      if (element.contains("url")) {
        parameters += '${'$element=${Uri.encodeComponent(qp)}'}&';
      } else {
        parameters += '${'$element=$qp'}&';
      }
    }
    parameters += "passphrase=$passphrase";
    return crypto.md5.convert(Utf8Encoder().convert(parameters)).toString();
  }
}
