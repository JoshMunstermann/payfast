class TokenizationBilling {
  static const String subscriptionType = '2';

  const TokenizationBilling({
    this.amount,
    this.itemName,
  });

  final String? amount;
  final String? itemName;

  Map<String, String> toMap() {
    return {
      if (amount != null) 'amount': amount!,
      if (itemName != null) 'item_name': itemName!,
      'subscription_type': subscriptionType,
    };
  }
}
