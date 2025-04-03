import 'package:baato_api/src/deprecated/baato_utils.dart';
import 'package:baato_api/src/deprecated/search.dart';
import 'package:dio/dio.dart';

/// A class to interact with Baato Search API
///
/// Provides functionality to search for places using Baato API
/// @deprecated This class is deprecated and will be removed in a future version
@deprecated
class BaatoSearch {
  String accessToken, query;
  String? appId;
  String? securityCode;
  String? type;
  String? apiVersion = "1";
  String? apiBaseUrl;
  int? radius;
  int? limit;
  double? lat, lon;

  late Dio _client;

  /// To initialize Baato Search API parameters
  /// using [query] and [accessToken]
  /// @deprecated This constructor is deprecated and will be removed in a future version
  @deprecated
  BaatoSearch.initialize({
    required this.query,
    required this.accessToken,
    this.appId,
    this.securityCode,
    this.apiBaseUrl,
    this.apiVersion,
    this.type,
    this.limit,
    this.radius,
    this.lat,
    this.lon,
  }) {
    _initializeDio();
  }

  /// Initialize Dio client for network requests
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  void _initializeDio() {
    _client = Dio(
      BaseOptions(baseUrl: apiBaseUrl ?? "https://api.baato.io/api/v1/search"),
    );
  }

  /// Search using baato API
  ///
  /// Searches for places based on the query and other parameters
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  Future<SearchResponse> searchQuery() async {
    Map responseBody;
    SearchResponse returnable;
    try {
      final response = await _client.get(
        apiBaseUrl ?? "https://api.baato.io/api/v1/search",
        queryParameters: getQueryParams(),
      );
      responseBody = response.data;
      returnable = SearchResponse.fromJson(responseBody);
    } on DioError catch (error) {
      if (error.response != null) {
        var response = error.response;
        responseBody = response?.data;
        throw Exception(response);
      } else {
        throw Exception("Failed to send Search request");
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
    var queryParams = {"key": accessToken, "q": query};
    if (type != null) queryParams['type'] = type!;
    if (radius != null) queryParams['radius'] = radius.toString();
    if (limit != null) queryParams['limit'] = limit.toString();
    if (lat != null) queryParams['lat'] = lat.toString();
    if (lon != null) queryParams['lon'] = lon.toString();
    if (appId != null && securityCode != null)
      queryParams['hash'] = BaatoUtils().generateHash(
        appId.toString(),
        accessToken,
        securityCode.toString(),
      );
    return queryParams;
  }
}
