# Payfast

Open-source wrapper library built to make using the Payfast API with Flutter much easier.

_N.B. Has only been tested in Payfast Sandbox!_

Use ngrok and nodejs getting started guide to recieve and respond to webhook.


## Usage
### Add import
```dart
import 'package:payfast/payfast.dart';
```

### Default Setup

```dart
var payfast = Payfast(
    passphrase: 'JoshuaMunstermann',
    paymentType: PaymentType.SimplePayment,
    production: false,
    merchantDetails: MerchantDetails(
      merchant_id: '10026561',
      merchant_key: 'cwon220sjr9ga',
      notify_url: 'https://b5f5-196-30-8-166.eu.ngrok.io',
      return_url: 'https://google.com',
    ),
  );
```

### Simple payment

```dart
payfast.createSimplePayment(amount: '100', itemName: 'TV');
print(payfast.generateURL());
```

### Recurring Billing

#### Subscription

```dart
payfast.setRecurringBillingType(RecurringPaymentType.subscription);
payfast.setupRecurringBillingSubscription(
    amount: 100,
    itemName: 'TV',
    billingDate: '2022-07-25',
    cycles: 2,
    cyclePeriod: FrequencyCyclePeriod.Monthly,
    recurringAmount: 300,
  );
print(payfast.generateURL());
```

#### Tokenization (Documentation incomplete)
```dart
payfast.setRecurringBillingType(RecurringPaymentType.tokenization);
payfast.setupRecurringBillingTokenization();
print(payfast.generateURL());
```

Inspired by https://github.com/GetTruck/payfast-js
