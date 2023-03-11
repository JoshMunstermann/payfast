class SubscriptionPayment {
  String amount;
  String itemName;
  late String subscriptionsType;
  String billingDate;
  String recurringAmount;
  String frequency;
  String cycles;

  SubscriptionPayment({
    required this.amount,
    required this.itemName,
    required this.billingDate,
    required this.recurringAmount,
    required this.frequency,
    required this.cycles,
  }) {
    subscriptionsType = '1';
  }

  void setupSubscriptionPayment(String test) {}
}
