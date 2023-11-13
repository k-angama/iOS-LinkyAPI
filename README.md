# iOS-LinkyAPI

The LinkyAPI Swift Library is a Swift package that provides a convenient way to access Linky's electricity consumption and production data through Enedis API. This library simplifies the process of obtaining user authorization, fetching consumption data.


## Reatures

- API authorization process.
- Retrieval of daily consumption, average power consumed, maximum consumption power, daily production, and average power produced.
- Structured Swift API for easy integration into your iOS applications.


## Requirements

LinkyAPI requires the following:

- Xcode 14+
- Swift 5.0+
- iOS 16.4+


## Installation

To install this framework using CocoaPods, add the following line to your Podfile:

```
pod 'LinkyAPI'
```

Then run pod install in your terminal.


## Before Started

### Developer Account and Application Registration

Before integrating the Linky API library into your Swift application, several preliminary steps must be completed, you need to create a developer account with Enedis. During this process, you will obtain essential credentials, including a client ID and client secret. Additionally, you must register an application specific to your use of the Linky API. This registration typically requires providing a valid SIRET number and entering into a contractual agreement with Enedis.

For more information and to access Enedis, visit [Enedis DataHub](https://datahub-enedis.fr/data-connect/).

### Library Integration

Once your developer account is activated, and the necessary contracts are signed, you can proceed to integrate the Linky API library into your Swift application. The library provides convenient structs and classes, such as LinkyConfiguration for setting up API access parameters and LinkyAuthorization for handling the authorization process.

> IMPORTANT: The application must be developed in 'sandbox' mode and implement a compliant customer journey before being able to access real data.

### Transition to Production

While you can use the Linky API in "sandbox" mode after completing the initial setup, transitioning to production mode requires an additional step. Specifically, you need to submit a request to Enedis for activation in production. Once approved, you can seamlessly switch from "sandbox" to production mode, allowing your application to access real user data.

## Usage

### Authorization

To authorize access to Linky's API, you need to create a LinkyConfiguration instance with your client ID, client secret, and other required parameters. Then, use the LinkyAuthorization class to initiate the authorization process.

```swift
let configuration = LinkyConfiguration(
    clientId: "your_client_id",
    clientSecret: "your_client_secret",
    redirectURI: URL(string: "your_redirect_uri")!,
    mode: .sandbox(prm: .client0),
    duration: .day(value: 1)
)
let linkyAuth = LinkyAuthorization(configuration: configuration)

// Launch the authorization request
linkyAuth.authorization { error in
    if error == nil {
        // Authorization successful, proceed with data retrieval
    } else {
        // Handle authorization error
    }
}
```

#### Sandbox Mode

The "sandbox" mode is used for development and testing purposes. In this mode, you can simulate electricity consumption and production data using specific delivery points, called PRMs (Measured Reference Points). These PRMs represent different scenarios, such as clients with specific consumption profiles.

In your implementation, the "sandbox" mode is configured using the LinkyMode structure with the .sandbox variant, specifying a particular PRM. For example:

```swift
let configuration = LinkyConfiguration(
    ...
    mode: .sandbox(prm: .client0), // Using PRM client0 to simulate specific data
    ...
)
```

#### Production Mode

The "production" mode is used when your application is ready to access real consumption and production electricity data from end-users through the Enedis network. In this mode, the retrieved data is real and reflects information from Linky meters in production.

To switch to "production" mode in your implementation, use the LinkyMode structure with the .production variant:

```swift
let configuration = LinkyConfiguration(
    ...
    mode: .sandbox(prm: .production),
    ...
)
```

When transitioning to "production" mode, ensure that your application is ready to handle real data and comply with all data protection and privacy regulations.

#### Duration of consent request

The duration parameter in the LinkyConfiguration struct represents the consent duration requested by the application when authorizing access to the Linky API. This duration will be displayed to the end-user during the authorization process. The user must grant explicit and informed consent for the specified duration.

```swift
let configuration = LinkyConfiguration(
    ...
    duration: .day(value: 1)
    ...
)
```

The duration parameter is of type LinkyDuration, which is an enumeration representing different time durations. The available options are:

* Day: Request consent for a specific number of days.
```swift
LinkyDuration.day(value: 7) // Request consent for 7 days
```

* Month: Request consent for a specific number of months.
```swift
LinkyDuration.month(value: 2) // Request consent for 2 months
```

* Year: Request consent for a specific number of years.
```swift
LinkyDuration.year(value: 3) // Request consent for 3 years
```

#### Redirect URI in Production

The redirectURI parameter is crucial, especially in a production environment. It is the URL that you will need to specify when requesting activation of your developer compte with Enedis for production.

```swift
let configuration = LinkyConfiguration(
    ...
    redirectURI: URL(string: "your_production_redirect_uri")!,
    ...
)
```

### Data Retrieval

Once authorized, you can use the LinkyConsumption struct to retrieve various consumption and production data.

```swift
// Retrieve daily consumption
LinkyConsumption.shared.daily(start: startDate, end: endDate) { consumption, error in
    if let consumption = consumption {
        // Handle daily consumption data
    } else {
        // Handle error
    }
}

// Retrieve average power consumed over a 30 min interval
LinkyConsumption.shared.loadcurve(start: startDate, end: endDate) { consumption, error in
    if let consumption = consumption {
        // Handle load curve data
    } else {
        // Handle error
    }
}
// Other data retrieval methods are available
```


## Contributing

Contributions to LinkyAPI are welcome! If you find any issues or have suggestions for improvement, please feel free to open an issue or submit a pull request.


## Author

k-angama, karim.angama@gmail.com


## License

LinkyAPI is available under the MIT license. See the LICENSE file for more info.
