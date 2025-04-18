import 'package:baato_api/baato_api.dart';

// Visit https://baato.io/ to get your ACCESS token

void main() async {
  // Your Baato API access token
  String baatoAccessToken = "<<YOUR BAATO ACCESS TOKEN>>";

  // Initialize the Baato API client with configuration
  final baatoAPI = BaatoAPI.initialize(
    apiKey: baatoAccessToken,
    appId: "<<YOUR APP ID>>",
    securityCode: "<<YOUR SECURITY CODE>>",
    connectTimeoutInSeconds: 10,
    receiveTimeoutInSeconds: 10,
    enableLogging: true,
  );

  // Search for places by name with optional parameters
  final response = await baatoAPI.place.search(
    'Teaching Hospital',
    type: 'hospital', // Filter results by place type
    limit: 5, // Maximum number of results to return
    currentCoordinate: BaatoCoordinate(
      latitude: 27.717844,
      longitude: 85.3248188,
    ), // Current location for context
  );
  print(response);

  // Search for places near a specific location
  final responseNearby = await baatoAPI.place.nearBy(
    BaatoCoordinate(
      latitude: 27.717844,
      longitude: 85.3248188,
    ), // Location to search around
    type: 'hospital', // Type of places to find
    limit: 5, // Maximum number of results
  );
  print(responseNearby);

  // Get routing directions between two points
  final responseRoute = await baatoAPI.direction.getRoutes(
    startCoordinate: BaatoCoordinate(
      latitude: 27.717844,
      longitude: 85.3248188,
    ), // Starting point
    endCoordinate: BaatoCoordinate(
      latitude: 27.6876224,
      longitude: 85.33827,
    ), // Destination point
    mode: BaatoDirectionMode.car, // Transportation mode
  );
  print(responseRoute);

  // Get detailed information about a specific place
  final placeResponse = await baatoAPI.place.getDetail(
    156068, // Unique place ID to look up
  );
  print(placeResponse);

  // Perform reverse geocoding to find places at specific coordinates
  final reverse = await baatoAPI.place.reverseGeocode(
    BaatoCoordinate(
      latitude: 27.7340912,
      longitude: 85.3368392,
    ), // Location to look up
    addressParseEnabled: false,
  );
  print(reverse);
}
