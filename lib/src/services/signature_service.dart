import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;

class SignatureService {
  static String createSignature(
    Map<String, String> queryParameters,
    String passphrase,
  ) {
    final entries = queryParameters.entries
        .where((entry) => entry.value.isNotEmpty)
        .toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    final buffer = StringBuffer();
    for (final entry in entries) {
      final encodedValue = entry.key.contains('url')
          ? Uri.encodeComponent(entry.value)
          : entry.value;
      buffer.write('${entry.key}=$encodedValue&');
    }

    buffer.write('passphrase=$passphrase');

    return crypto.md5.convert(utf8.encode(buffer.toString())).toString();
  }
}
