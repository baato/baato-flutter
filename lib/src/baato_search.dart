import 'package:baato_api/models/search.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'exceptions.dart';

class BaatoSearch {
  String accessToken, query;
  String type;
  String apiVersion = "1";
  String apiBaseUrl = "https://api.baato.io/api/v1/search";
  int radius = 0, limit = 0;
  double lat = 0.00, lon = 0.00;

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
      final response = await _client.get(apiBaseUrl, queryParameters: {
        "key": accessToken,
        "q": query,
        "type": type,
        "radius": radius,
        "limit": limit,
        "lat": lat,
        "lon": lon
      });
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
}
