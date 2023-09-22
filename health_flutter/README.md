# health_flutter

Flutter plugin for integration with iOS [HealthKit](https://developer.apple.com/documentation/healthkit) & Android [Health Connect](https://developer.android.com/health-and-fitness/guides/health-connect).

:warning: **Currently the plugin supports only reading the data. Writing will be added in upcoming releases**. :warning:

### Setup

#### iOS
```
Note: health_flutter is available for iOS 13 and higher due to HealthKit requirements. 
```

##### 1. Add HealthKit as capability:
Go to `Runner`->`Signing & Capabilities`->`+ Capability` (in top left corner) -> add `HealthKit`
##### 2. Please include these descriptions in your `Info.plist` file:

```
<key>NSHealthShareUsageDescription</key>
<string>Your usage description goes here</string>
<key>NSHealthUpdateUsageDescription</key>
<string>Your usage description goes here</string>
```

#### Android

```
Note: The Health Connect SDK supports Android 8 (API level 26) at the minimum, 
while the Health Connect app is only compatible with Android 9 (API level 28) or higher. 
This means that third-party apps can support users with Android 8, 
but only users with Android 9 or higher can use Health Connect.
```

##### 1. Update your manifest file with required query.
TODO: provide query.

##### 2. Add desired permissions to your Android Manifest file.

* Here are all available [permissions](https://developer.android.com/health-and-fitness/guides/health-connect/data-and-data-types/data-types#permissions).


### Available data types
###### (Keep types list in alphabetical order)

| **Name** | **Unit** | **iOS** | **Android** |
| ----------- | ----------- | ----------- | ----------- |
| activeEnergyBurned | kilocalorie | [Yes](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/1615771-activeenergyburned) :white_check_mark: | [Yes](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/ActiveCaloriesBurnedRecord) :white_check_mark: |
| basalBodyTemperature | degree (celsius) | [Yes](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/1615763-basalbodytemperature) :white_check_mark: | [Yes](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BasalBodyTemperatureRecord) :white_check_mark: |
| basalEnergyBurned | kilocalorie | [Yes](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/1615512-basalenergyburned) :white_check_mark: | [Yes](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BasalMetabolicRateRecord) :white_check_mark: |
