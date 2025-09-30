/// Frequency options for Payfast subscription billing.
enum FrequencyCyclePeriod {
  monthly,
  quarterly,
  biannually,
  annual,
}

extension FrequencyCyclePeriodX on FrequencyCyclePeriod {
  /// Returns the billing frequency value expected by Payfast.
  String get payfastCode {
    switch (this) {
      case FrequencyCyclePeriod.monthly:
        return '3';
      case FrequencyCyclePeriod.quarterly:
        return '4';
      case FrequencyCyclePeriod.biannually:
        return '5';
      case FrequencyCyclePeriod.annual:
        return '6';
    }
  }
}
