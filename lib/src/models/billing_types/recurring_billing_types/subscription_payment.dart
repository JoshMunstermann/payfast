class SubscriptionPayment {
  static const String subscriptionType = '1';

  const SubscriptionPayment({
    required this.amount,
    required this.itemName,
    required this.billingDate,
    required this.recurringAmount,
    required this.frequency,
    required this.cycles,
  });

  final String amount;
  final String itemName;
  final String billingDate;
  final String recurringAmount;
  final String frequency;
  final String cycles;

  Map<String, String> toMap() {
    return {
      'amount': amount,
      'item_name': itemName,
      'subscription_type': subscriptionType,
      'billing_date': billingDate,
      'recurring_amount': recurringAmount,
      'frequency': frequency,
      'cycles': cycles,
    };
  }
}
