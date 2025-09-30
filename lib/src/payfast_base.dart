import 'package:payfast/src/enums/enums.dart';
import 'package:payfast/src/models/billing_types/recurring_billing.dart';
import 'package:payfast/src/models/billing_types/recurring_billing_types/subscription_payment.dart';
import 'package:payfast/src/models/billing_types/recurring_billing_types/tokenization_billing.dart';
import 'package:payfast/src/models/billing_types/simple_billing.dart';
import 'package:payfast/src/models/merchant_details.dart';
import 'package:payfast/src/services/signature_service.dart';

class Payfast {
  Payfast({
    required this.passphrase,
    required this.paymentType,
    required this.production,
    required this.merchantDetails,
  });

  final String passphrase;
  final PaymentType paymentType;
  final bool production;
  final MerchantDetails merchantDetails;

  SimpleBilling? _simpleBilling;
  RecurringBilling? _recurringBilling;
  RecurringPaymentType? _recurringPaymentType;

  String generateURL() => buildPaymentUri().toString();

  Uri buildPaymentUri() {
    final queryParameters = _buildQueryParameters();
    final signature = SignatureService.createSignature(
      queryParameters,
      passphrase,
    );

    final hostPrefix = production ? 'payfast' : 'sandbox.payfast';

    return Uri(
      scheme: 'https',
      host: '$hostPrefix.co.za',
      path: '/eng/process',
      queryParameters: {
        ...queryParameters,
        'signature': signature,
      },
    );
  }

  void createSimplePayment({
    required String amount,
    required String itemName,
  }) {
    _simpleBilling = SimpleBilling(
      amount: amount,
      itemName: itemName,
    );
  }

  void setRecurringBillingType(RecurringPaymentType recurringPaymentType) {
    _recurringPaymentType = recurringPaymentType;
  }

  void setupRecurringBillingSubscription({
    required int amount,
    required String itemName,
    required String billingDate,
    required int cycles,
    required FrequencyCyclePeriod cyclePeriod,
    required int recurringAmount,
  }) {
    _assertRecurringType(RecurringPaymentType.subscription);

    _recurringBilling = RecurringBilling.subscription(
      subscriptionPayment: SubscriptionPayment(
        amount: amount.toString(),
        itemName: itemName,
        billingDate: billingDate,
        recurringAmount: recurringAmount.toString(),
        frequency: cyclePeriod.payfastCode,
        cycles: cycles.toString(),
      ),
    );
  }

  void setupRecurringBillingTokenization({
    int? amount,
    String? itemName,
  }) {
    _assertRecurringType(RecurringPaymentType.tokenization);

    _recurringBilling = RecurringBilling.tokenization(
      tokenizationBilling: TokenizationBilling(
        amount: amount?.toString(),
        itemName: itemName,
      ),
    );
  }

  void chargeTokenization() {
    final queryParameters = <String, String>{
      'token': '3ee21522-7cc9-464d-837a-3e791c5a6f1d',
      'merchant-id': '10026561',
      'version': 'v1',
      'timestamp': '2022-07-25',
      'amount': '444',
      'item_name': 'Netflix',
    };

    final signature = SignatureService.createSignature(
      queryParameters,
      passphrase,
    );

    final signedQuery = {
      ...queryParameters,
      'signature': signature,
    };

    print(signedQuery);
  }

  Map<String, String> _buildQueryParameters() {
    switch (paymentType) {
      case PaymentType.simplePayment:
        final billing = _simpleBilling;
        if (billing == null) {
          throw StateError('Simple billing details have not been configured.');
        }
        return {
          ...merchantDetails.toMap(),
          ...billing.toMap(),
        };
      case PaymentType.recurringBilling:
        final billing = _recurringBilling;
        if (billing == null) {
          throw StateError('Recurring billing details have not been configured.');
        }
        return {
          ...merchantDetails.toMap(),
          ...billing.toMap(),
        };
    }
  }

  void _assertRecurringType(RecurringPaymentType expectedType) {
    if (_recurringPaymentType == null) {
      _recurringPaymentType = expectedType;
      return;
    }

    if (_recurringPaymentType != expectedType) {
      throw StateError(
        'Recurring billing configured for $_recurringPaymentType but attempted to configure $expectedType.',
      );
    }
  }
}
