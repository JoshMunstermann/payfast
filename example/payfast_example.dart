import 'package:payfast/payfast.dart';
import 'package:payfast/src/merchant_details.dart';

//New updates, introducted new type of subscription payment - tokenization, added support for return, cancel and notify urls and refactored some of the code.
//Use ngrok and nodejs getting started guide to recieve and respond to webhook.

void main() {
  //Default setup
  var payfast = Payfast(
    passphrase: 'JoshuaMunstermann',
    paymentType: PaymentType.SimplePayment,
    production: false,
    merchantDetails: MerchantDetails(
      merchant_id: '10026561',
      merchant_key: 'cwon220sjr9ga',
      notify_url: 'https://b5f5-196-30-8-166.eu.ngrok.io',
      return_url: 'https://google.com',
    ),
  );

  //Payfast Simple Payment example:
  payfast.createSimplePayment(amount: '100', itemName: 'TV');

  //Payfast set Recurring Billing type:
  payfast.setRecurringBillingType(RecurringPaymentType.tokenization);

  //Payfast Recurring Billing Subscription example:
  payfast.setupRecurringBillingSubscription(
    amount: 100,
    itemName: 'TV',
    billingDate: '2022-07-25',
    cycles: 2,
    cyclePeriod: FrequencyCyclePeriod.Monthly,
    recurringAmount: 300,
  );

  //Payfast Recurring Billing Tokenization example:
  payfast.setupRecurringBillingTokenization();

  // print(payfast.generateURL());

  payfast.chargeTokenization();
}
