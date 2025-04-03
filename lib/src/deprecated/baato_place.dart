import 'package:baato_api/src/deprecated/baato_utils.dart';
import 'package:baato_api/src/deprecated/place.dart';
import 'package:dio/dio.dart';

/// A class to interact with Baato Place API
///
/// Provides functionality to fetch place details using Baato API
/// @deprecated This class is deprecated and will be removed in a future version
@deprecated
class BaatoPlace {
  String accessToken;
  String? apiVersion = "1";
  String? apiBaseUrl;
  String? appId;
  String? securityCode;
  int placeId = 0;

  late Dio _client;

  /// To initialize Baato Place API parameters
  /// using [placeId] and [accessToken]
  /// @deprecated This constructor is deprecated and will be removed in a future version
  @deprecated
  BaatoPlace.initialize({
    required this.placeId,
    required this.accessToken,
    this.apiBaseUrl,
    this.appId,
    this.securityCode,
    this.apiVersion,
  }) {
    _initializeDio();
  }

  /// Initialize Dio client for network requests
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  void _initializeDio() {
    _client = Dio(
      BaseOptions(baseUrl: apiBaseUrl ?? "https://api.baato.io/api/v1/places"),
    );
  }

  /// Place Details using Baato API
  ///
  /// Fetches place details from Baato API using the configured place ID
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  Future<PlaceResponse> getPlaceDetails() async {
    Map responseBody;
    PlaceResponse returnable;
    try {
      final response = await _client.get(
        apiBaseUrl ?? "https://api.baato.io/api/v1/places",
        queryParameters: getQueryParams(),
      );
      responseBody = response.data;
      returnable = PlaceResponse.fromJson(responseBody);
    } on DioError catch (error) {
      if (error.response != null) {
        var response = error.response;
        responseBody = response?.data;
        throw Exception(response);
      } else {
        throw Exception("Failed to send place request");
      }
    }
    return returnable;
  }

  /// Builds query parameters for API requests
  ///
  /// Creates a map of query parameters including authentication details
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  Map<String, dynamic> getQueryParams() {
    var queryParams = {"key": accessToken, "placeId": placeId};
    if (appId != null && securityCode != null)
      queryParams['hash'] = BaatoUtils().generateHash(
        appId.toString(),
        accessToken,
        securityCode.toString(),
      );
    return queryParams;
  }
}
