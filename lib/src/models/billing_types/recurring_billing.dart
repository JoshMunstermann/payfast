import 'package:payfast/src/enums/recurring_payment_types.dart';
import 'package:payfast/src/models/billing_types/recurring_billing_types/subscription_payment.dart';
import 'package:payfast/src/models/billing_types/recurring_billing_types/tokenization_billing.dart';

class RecurringBilling {
  const RecurringBilling._({
    required this.recurringPaymentType,
    this.subscriptionPayment,
    this.tokenizationBilling,
  });

  const RecurringBilling.subscription({
    required SubscriptionPayment subscriptionPayment,
  }) : this._(
          recurringPaymentType: RecurringPaymentType.subscription,
          subscriptionPayment: subscriptionPayment,
        );

  const RecurringBilling.tokenization({
    required TokenizationBilling tokenizationBilling,
  }) : this._(
          recurringPaymentType: RecurringPaymentType.tokenization,
          tokenizationBilling: tokenizationBilling,
        );

  final RecurringPaymentType recurringPaymentType;
  final SubscriptionPayment? subscriptionPayment;
  final TokenizationBilling? tokenizationBilling;

  Map<String, String> toMap() {
    switch (recurringPaymentType) {
      case RecurringPaymentType.subscription:
        final subscription = subscriptionPayment;
        if (subscription == null) {
          throw StateError('Subscription payment details have not been configured.');
        }
        return subscription.toMap();
      case RecurringPaymentType.tokenization:
        final tokenization = tokenizationBilling;
        if (tokenization == null) {
          throw StateError('Tokenization billing details have not been configured.');
        }
        return tokenization.toMap();
    }
  }
}
