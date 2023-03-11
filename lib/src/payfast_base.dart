import 'package:payfast/src/models/billing_types/recurring_billing_types/subscription_payment.dart';
import 'package:payfast/src/models/billing_types/recurring_billing_types/tokenization_billing.dart';
import 'package:payfast/src/models/merchant_details.dart';
import 'package:payfast/src/services/signature_service.dart';
import 'package:payfast/src/enums/enums.dart';

import 'models/billing_types/recurring_billing.dart';
import 'models/billing_types/simple_billing.dart';

class Payfast {
  String passphrase;
  PaymentType paymentType;
  bool production;

  RecurringBilling? recurringBilling;
  SimpleBilling? simpleBilling;
  // TokenizationBilling? tokenizationBilling;
  MerchantDetails merchantDetails;

  Payfast({
    required this.passphrase,
    required this.paymentType,
    required this.production,
    required this.merchantDetails,
  });

  String generateURL() {
    Map<String, dynamic> queryParameters = {};
    //Simple Payment
    if (paymentType == PaymentType.simplePayment) {
      Map<String, dynamic> simpleQueryParameters = {
        ...merchantDetails.toMap(),
        'amount': simpleBilling?.amount,
        'item_name': simpleBilling?.itemName,
      };

      queryParameters = simpleQueryParameters;
    }
    //Recurring Billing
    else if (paymentType == PaymentType.recurringBilling) {
      //Subscription
      if (recurringBilling?.recurringPaymentType ==
          RecurringPaymentType.subscription) {
        Map<String, dynamic> recurringSubscriptionQueryParameters = {
          ...merchantDetails.toMap(),
          'amount': recurringBilling?.subscriptionPayment?.amount,
          'item_name': recurringBilling?.subscriptionPayment?.itemName,
          'subscription_type':
              recurringBilling?.subscriptionPayment?.subscriptionsType,
          'billing_date': recurringBilling?.subscriptionPayment?.billingDate,
          'recurring_amount':
              recurringBilling?.subscriptionPayment?.recurringAmount,
          'frequency': recurringBilling?.subscriptionPayment?.frequency,
          'cycles': recurringBilling?.subscriptionPayment?.cycles,
        };

        queryParameters = recurringSubscriptionQueryParameters;
      }
      //Tokenization
      else if (recurringBilling?.recurringPaymentType ==
          RecurringPaymentType.tokenization) {
        Map<String, dynamic> recurringTokenizationQueryParameters = {
          ...merchantDetails.toMap(),
          'amount': '250',
          'item_name': 'Netflix',
          'subscription_type':
              recurringBilling?.tokenizationBilling?.subscription_type,
        };

        queryParameters = recurringTokenizationQueryParameters;
      } else {
        throw Exception("Payment type not selected");
      }
    }

    return Uri.decodeComponent(
      Uri(
        scheme: 'https',
        host: '${production ? 'payfast' : 'sandbox.payfast'}.co.za',
        path: '/eng/process',
        queryParameters: {
          ...queryParameters,
          'signature': SignatureService.createSignature(
            queryParameters,
            passphrase,
          ),
        },
      ).toString(),
    );
  }

  void createSimplePayment({
    required String amount,
    required String itemName,
  }) {
    simpleBilling = SimpleBilling(
      amount: amount,
      itemName: itemName,
    );
  }

  void setRecurringBillingType(RecurringPaymentType recurringPaymentType) {
    recurringBilling =
        RecurringBilling(recurringPaymentType: recurringPaymentType);
  }

  void setupRecurringBillingSubscription({
    required int amount,
    required String itemName,
    required String billingDate,
    required int cycles,
    required FrequencyCyclePeriod cyclePeriod,
    required int recurringAmount,
  }) {
    recurringBilling!.subscriptionPayment = SubscriptionPayment(
      amount: amount.toString(),
      itemName: itemName,
      billingDate: billingDate,
      recurringAmount: recurringAmount.toString(),
      frequency: (cyclePeriod.index + 3).toString(),
      cycles: cycles.toString(),
    );
  }

  void setupRecurringBillingTokenization([
    int? amount,
    String? itemName,
  ]) {
    recurringBilling!.tokenizationBilling = TokenizationBilling(
      amount.toString(),
      itemName,
    );
  }

  void chargeTokenization() {
    Map<String, dynamic> recurringTokenizationQueryParameters = {
      'token': '3ee21522-7cc9-464d-837a-3e791c5a6f1d',
      'merchant-id': '10026561',
      'version': 'v1',
      'timestamp': '2022-07-25',
      'amount': '444',
      'item_name': 'Netflix',
    };

    Map<String, dynamic> signatureEntry = {
      'signature': SignatureService.createSignature(
          recurringTokenizationQueryParameters, 'JoshuaMunstermann'),
    };

    recurringTokenizationQueryParameters.addEntries(signatureEntry.entries);

    print(recurringTokenizationQueryParameters);
  }
}
