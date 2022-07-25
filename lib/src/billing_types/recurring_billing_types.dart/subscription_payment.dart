class SubscriptionPayment {
  String amount;
  String item_name;
  late String subscriptions_type;
  String billing_date;
  String recurring_amount;
  String frequency;
  String cycles;

  SubscriptionPayment({
    required this.amount,
    required this.item_name,
    required this.billing_date,
    required this.recurring_amount,
    required this.frequency,
    required this.cycles,
  }) {
    subscriptions_type = '1';
  }

  void setupSubscriptionPayment(String test) {}
}
