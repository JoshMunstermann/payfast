class MerchantDetails {
  const MerchantDetails({
    required this.merchantId,
    required this.merchantKey,
    this.returnUrl,
    this.cancelUrl,
    this.notifyUrl,
  });

  final String merchantId;
  final String merchantKey;
  final String? returnUrl;
  final String? cancelUrl;
  final String? notifyUrl;

  Map<String, String> toMap() {
    return {
      'merchant_id': merchantId,
      'merchant_key': merchantKey,
      if (returnUrl != null) 'return_url': returnUrl!,
      if (cancelUrl != null) 'cancel_url': cancelUrl!,
      if (notifyUrl != null) 'notify_url': notifyUrl!,
    };
  }
}
