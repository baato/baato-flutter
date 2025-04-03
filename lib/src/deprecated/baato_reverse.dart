import 'package:baato_api/src/deprecated/baato_utils.dart';
import 'package:baato_api/src/deprecated/place.dart';
import 'package:dio/dio.dart';

/// A class to interact with Baato Reverse Geocoding API
///
/// Provides functionality to convert coordinates to place information using Baato API
/// @deprecated This class is deprecated and will be removed in a future version
@deprecated
class BaatoReverse {
  String accessToken;
  String? apiVersion = "1";
  String? apiBaseUrl;
  int? radius;
  int? limit;
  String? appId;
  String? securityCode;
  GeoCoord latLon;

  late Dio _client;

  /// To initialize Baato Reverse API parameters
  /// using [latLon] and [accessToken]
  /// @deprecated This constructor is deprecated and will be removed in a future version
  @deprecated
  BaatoReverse.initialize({
    required this.latLon,
    required this.accessToken,
    this.appId,
    this.securityCode,
    this.apiBaseUrl,
    this.apiVersion,
    this.radius,
    this.limit,
  }) {
    _initializeDio();
  }

  /// Initialize Dio client for network requests
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  void _initializeDio() {
    _client = Dio(
      BaseOptions(baseUrl: apiBaseUrl ?? "https://api.baato.io/api/v1/reverse"),
    );
  }

  /// Reverse Search in baato
  ///
  /// Converts geographic coordinates to place information
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  Future<PlaceResponse> reverseGeocode() async {
    Map responseBody;
    PlaceResponse returnable;
    try {
      final response = await _client.get(
        apiBaseUrl ?? "https://api.baato.io/api/v1/reverse",
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
        throw Exception("Failed to send Reverse request");
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
    var queryParams = {
      "key": accessToken,
      "lat": latLon.lat,
      "lon": latLon.lon,
    };
    if (radius != null) queryParams['radius'] = radius!;
    if (limit != null) queryParams['limit'] = limit!;
    if (appId != null && securityCode != null)
      queryParams['hash'] = BaatoUtils().generateHash(
        appId.toString(),
        accessToken,
        securityCode.toString(),
      );
    return queryParams;
  }
}
