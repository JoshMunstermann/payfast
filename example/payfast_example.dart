import 'package:payfast/payfast.dart';
import 'package:payfast/src/models/merchant_details.dart';

void main() {
  final payfast = Payfast(
    passphrase: 'JoshuaMunstermann',
    paymentType: PaymentType.simplePayment,
    production: false,
    merchantDetails: const MerchantDetails(
      merchantId: '10026561',
      merchantKey: 'cwon220sjr9ga',
      notifyUrl: 'https://b5f5-196-30-8-166.eu.ngrok.io',
      returnUrl: 'https://google.com',
    ),
  );

  payfast.createSimplePayment(amount: '100', itemName: 'TV');

  payfast.setRecurringBillingType(RecurringPaymentType.tokenization);

  payfast.setupRecurringBillingSubscription(
    amount: 100,
    itemName: 'TV',
    billingDate: '2022-07-25',
    cycles: 2,
    cyclePeriod: FrequencyCyclePeriod.monthly,
    recurringAmount: 300,
  );

  payfast.setupRecurringBillingTokenization();

  print(payfast.generateURL());

  payfast.chargeTokenization();
}
