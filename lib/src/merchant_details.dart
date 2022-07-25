class MerchantDetails {
  String merchant_id;
  String merchant_key;
  String? return_url;
  String? cancel_url;
  String? notify_url;

  MerchantDetails({
    required this.merchant_id,
    required this.merchant_key,
    this.return_url,
    this.cancel_url,
    this.notify_url,
  });

  Map<String, dynamic> toMap() {
    return {
      "merchant_id": merchant_id,
      "merchant_key": merchant_key,
      if (return_url != null) "return_url": return_url,
      if (cancel_url != null) "cancel_url": cancel_url,
      if (notify_url != null) "notify_url": notify_url,
    };
  }
}
