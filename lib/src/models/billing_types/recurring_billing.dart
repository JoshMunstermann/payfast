import 'package:payfast/src/enums/recurring_payment_types.dart';
import 'package:payfast/src/models/billing_types/recurring_billing_types/subscription_payment.dart';
import 'package:payfast/src/models/billing_types/recurring_billing_types/tokenization_billing.dart';

class RecurringBilling {
  SubscriptionPayment? subscriptionPayment;
  TokenizationBilling? tokenizationBilling;

  RecurringPaymentType recurringPaymentType;

  RecurringBilling({
    required this.recurringPaymentType,
  });
}
