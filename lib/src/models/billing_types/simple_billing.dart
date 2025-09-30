class SimpleBilling {
  const SimpleBilling({
    required this.amount,
    required this.itemName,
  });

  final String amount;
  final String itemName;

  Map<String, String> toMap() {
    return {
      'amount': amount,
      'item_name': itemName,
    };
  }
}
