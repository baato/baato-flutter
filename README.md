[![Pub](https://img.shields.io/pub/v/baato_api.svg)](https://pub.dev/packages/baato_api)

# Baato API for Flutter

Baato API is a comprehensive Flutter package designed to interact with [Baato](https://baato.io) APIs. This package allows developers to integrate Baato's powerful location-based services into their Flutter applications, including place search, reverse geocoding, place details, and routing directions.

## Features

- **Place Search**: Search for places by name, type, and location with optional parameters for filtering results.
- **Nearby Places**: Discover places around a specific location, filtered by type and sorted by distance.
- **Reverse Geocoding**: Convert geographic coordinates into human-readable place information.
- **Place Details**: Retrieve detailed information about specific places using unique place IDs.
- **Directions**: Get routing directions between two points with support for various transportation modes such as car, bike, and foot.

## Implementation

To use the Baato API in your Flutter application, follow these steps:

1. **Initialize the Baato API client**:

   ```dart
   // Your Baato API access token
   String baatoAccessToken = "<<YOUR ACCESS TOKEN>>";

   // Initialize the Baato API client with configuration
   final baatoAPI = BaatoAPI.initialize(
     apiKey: baatoAccessToken,
     appId: "<<YOUR APP ID>>",
     securityCode: "<<YOUR SECURITY CODE>>",
     connectTimeoutInSeconds: 10,
     receiveTimeoutInSeconds: 10,
     enableLogging: true,
   );
   ```

2. **Search for places by name**:

   ```dart
   final response = await baatoAPI.place.search(
     'Teaching Hospital',
     type: 'hospital', // Filter results by place type
     limit: 5, // Maximum number of results to return
     currentCoordinate: BaatoCoordinate(27.717844, 85.3248188), // Current location for context
   );
   print(response);
   ```

3. **Search for nearby places**:

   ```dart
   final responseNearby = await baatoAPI.place.nearBy(
     BaatoCoordinate(27.717844, 85.3248188), // Location to search around
     type: 'hospital', // Type of places to find
     limit: 5, // Maximum number of results
   );
   print(responseNearby);
   ```

4. **Get routing directions between two points**:

   ```dart
   final responseRoute = await baatoAPI.direction.getRoutes(
     startCoordinate: BaatoCoordinate(27.717844, 85.3248188), // Starting point
     endCoordinate: BaatoCoordinate(27.6876224, 85.33827), // Destination point
     mode: BaatoDirectionMode.car, // Transportation mode
   );
   print(responseRoute);
   ```

5. **Get detailed information about a specific place**:

   ```dart
   final placeResponse = await baatoAPI.place.getDetail(
     156068, // Unique place ID to look up
   );
   print(placeResponse);
   ```

6. **Perform reverse geocoding to find places at specific coordinates**:
   ```dart
   final reverse = await baatoAPI.place.reverseGeocode(
     BaatoCoordinate(27.7340912, 85.3368392), // Location to look up
   );
   print(reverse);
   ```

For more detailed documentation and examples, visit the [Baato API GitHub repository](https://github.com/baato/baato-flutter.git).

## Installation

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
