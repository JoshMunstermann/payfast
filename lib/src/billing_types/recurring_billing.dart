import 'package:payfast/payfast.dart';
import 'package:payfast/src/billing_types/recurring_billing_types.dart/subscription_payment.dart';
import 'package:payfast/src/billing_types/recurring_billing_types.dart/tokenization_billing.dart';

class RecurringBilling {
  SubscriptionPayment? subscriptionPayment;
  TokenizationBilling? tokenizationBilling;

  RecurringPaymentType recurringPaymentType;

  RecurringBilling({
    required this.recurringPaymentType,
  });
}
