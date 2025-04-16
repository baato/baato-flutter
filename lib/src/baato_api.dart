import 'package:baato_api/src/api/baato_dio.dart';
import 'package:baato_api/src/api/baato_direction_api.dart';
import 'package:baato_api/src/api/baato_place_api.dart';

/// Main entry point for the Baato API client
///
/// This class provides a centralized configuration for all Baato API services
/// and allows creating instances of specific API clients.
class BaatoAPI {
  static BaatoAPI? _sharedInstance;

  final BaatoPlaceAPI place;
  final BaatoDirectionAPI direction;

  static BaatoAPI get shared {
    if (_sharedInstance == null) {
      throw Exception(
        "BaatoAPI not initialized. Call BaatoAPI.configure() first.",
      );
    }
    return _sharedInstance!;
  }

  BaatoAPI._({required this.place, required this.direction});

  /// Creates a new BaatoAPI instance with the specified configuration
  ///
  /// [apiKey] - The API key for authentication
  /// [appId] - Optional app ID for hash-based authentication
  /// [securityCode] - Optional security code for hash-based authentication
  /// [connectTimeoutInSeconds] - The connection timeout in seconds (defaults to 10)
  /// [receiveTimeoutInSeconds] - The receive timeout in seconds (defaults to 10)
  /// [enableLogging] - Whether to add a logging interceptor for debugging (defaults to false)
  static BaatoAPI initialize({
    required String apiKey,
    String? appId,
    String? securityCode,
    int connectTimeoutInSeconds = 10,
    int receiveTimeoutInSeconds = 10,
    bool enableLogging = false,
  }) {
    String apiBaseUrl = "https://api.baato.io/api";
    String apiVersion = "v1";

    final dio = BaatoDio(
      apiKey: apiKey,
      apiBaseUrl: apiBaseUrl,
      appId: appId,
      securityCode: securityCode,
      apiVersion: apiVersion,
      connectTimeoutInSeconds: connectTimeoutInSeconds,
      receiveTimeoutInSeconds: receiveTimeoutInSeconds,
      addLoggingInterceptor: enableLogging,
    );

    _sharedInstance = BaatoAPI._(
      place: BaatoPlaceImpl(dio: dio),
      direction: BaatoDirectionImpl(dio: dio),
    );

    return _sharedInstance!;
  }
}
