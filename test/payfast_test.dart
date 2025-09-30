import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:payfast/payfast.dart';
import 'package:payfast/src/models/merchant_details.dart';
import 'package:payfast/src/services/signature_service.dart';
import 'package:test/test.dart';

void main() {
  group('SignatureService', () {
    test('creates deterministic signatures with sorted parameters', () {
      final parameters = {
        'merchant_key': 'key',
        'return_url': 'https://example.com/path?query=1',
        'merchant_id': 'id',
        'amount': '100',
        'empty': '',
      };

      final signature = SignatureService.createSignature(parameters, 'pass');

      const expectedRaw =
          'amount=100&merchant_id=id&merchant_key=key&return_url=https%3A%2F%2Fexample.com%2Fpath%3Fquery%3D1&passphrase=pass';
      final expectedSignature =
          crypto.md5.convert(utf8.encode(expectedRaw)).toString();

      expect(signature, expectedSignature);
    });
  });

  group('Payfast', () {
    test('builds sandbox uri for simple payment', () {
      final payfast = Payfast(
        passphrase: 'test',
        paymentType: PaymentType.simplePayment,
        production: false,
        merchantDetails: const MerchantDetails(
          merchantId: '12345',
          merchantKey: 'abcde',
        ),
      );

      payfast.createSimplePayment(amount: '100', itemName: 'TV');

      final uri = payfast.buildPaymentUri();

      expect(uri.scheme, 'https');
      expect(uri.host, 'sandbox.payfast.co.za');
      expect(uri.queryParameters['merchant_id'], '12345');
      expect(uri.queryParameters['amount'], '100');

      final expectedSignature = SignatureService.createSignature({
        'merchant_id': '12345',
        'merchant_key': 'abcde',
        'amount': '100',
        'item_name': 'TV',
      }, 'test');

      expect(uri.queryParameters['signature'], expectedSignature);
    });

    test('throws when billing details are missing', () {
      final payfast = Payfast(
        passphrase: 'test',
        paymentType: PaymentType.simplePayment,
        production: false,
        merchantDetails: const MerchantDetails(
          merchantId: '12345',
          merchantKey: 'abcde',
        ),
      );

      expect(payfast.buildPaymentUri, throwsStateError);
    });
  });
}
