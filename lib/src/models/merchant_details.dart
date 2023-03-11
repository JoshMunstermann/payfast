class MerchantDetails {
  String merchantId;
  String merchantKey;
  String? returnUrl;
  String? cancelUrl;
  String? notifyUrl;

  MerchantDetails({
    required this.merchantId,
    required this.merchantKey,
    this.returnUrl,
    this.cancelUrl,
    this.notifyUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      "merchant_id": merchantId,
      "merchant_key": merchantKey,
      if (returnUrl != null) "return_url": returnUrl,
      if (cancelUrl != null) "cancel_url": cancelUrl,
      if (notifyUrl != null) "notify_url": notifyUrl,
    };
  }
}
