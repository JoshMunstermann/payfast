# Payfast

Open-source wrapper library built to make using the Payfast API with Flutter much easier.

_N.B. Has only been tested in Payfast Sandbox!_

## Usage
#### Add import
```dart
import 'package:payfast/payfast.dart';
```
#### Setup simple payment

```dart
var payfast = Payfast(
merchantId: 'merchant-id',
merchantKey: 'merchant-key',
passphrase: 'passphrase-set-in-sandbox',
paymentType: PaymentType.SimplePayment,
production: true || false,
);

payfast.createSimplePayment(
amount: 100,
itemName: 'Soap',
);
```
#### Setup recurring payment

```dart
var payfast = Payfast(
merchantId: 'merchant-id',
merchantKey: 'merchant-key',
passphrase: 'passphrase-set-in-sandbox',
paymentType: PaymentType.RecurringBilling,
production: true || false,
);

payfast.createSubsriptionPayment(
amount: 100,
itemName: 'CAS',
subscriptionType: SubscriptionType.subscription,
billingDate: '2022-07-06',
cycles: 2,
cyclePeriod: FrequencyCyclePeriod.Monthly,
recurringAmount: 100,
);
```
#### Generate Url
```dart
print(payfast.generateURL());
```
Inspired by https://github.com/GetTruck/payfast-js
