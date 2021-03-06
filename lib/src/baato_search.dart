import 'package:baato_api/models/search.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'exceptions.dart';

class BaatoSearch {
  String accessToken, query;
  String type;
  String apiVersion = "1";
  String apiBaseUrl = "https://api.baato.io/api/v1/search";
  int radius;
  int limit;
  double lat, lon;

  Dio _client;

  /// To initialize Baato Search API parameters
  /// using [query] and [accessToken]
  BaatoSearch.initialize(
      {@required this.query,
      @required this.accessToken,
      this.apiBaseUrl = "https://api.baato.io/api/v1/search",
      this.apiVersion,
      this.type,
      this.limit,
      this.radius,
      this.lat,
      this.lon}) {
    if (query == null) {
      throw IsNullException('The public key cannot be null');
    }
    if (accessToken == null) {
      throw IsNullException('The access token cannot be null');
    }
    _initializeDio();
  }

  /// Initialize Dio client for network requests
  void _initializeDio() {
    _client = Dio(BaseOptions(baseUrl: apiBaseUrl));
  }

  /// Search using baato API
  Future<SearchResponse> searchQuery() async {
    Map responseBody;
    SearchResponse returnable;
    try {
      final response =
          await _client.get(apiBaseUrl, queryParameters: getQueryParams());
      responseBody = response.data;
      returnable = SearchResponse.fromJson(responseBody);
    } on DioError catch (error) {
      if (error.response != null) {
        var response = error.response;
        responseBody = response.data;
        throw Exception(responseBody['message']);
      } else {
        throw Exception("Failed to send Search request");
      }
    }
    return returnable;
  }

  Map<String, dynamic> getQueryParams() {
    var queryParams = {"key": accessToken, "q": query};
    if (type != null) queryParams['type'] = type;
    if (radius != null) queryParams['radius'] = radius.toString();
    if (limit != null) queryParams['limit'] = limit.toString();
    if (lat != null) queryParams['lat'] = lat.toString();
    if (lon != null) queryParams['lon'] = lon.toString();
    print(queryParams);
    return queryParams;
  }
}
