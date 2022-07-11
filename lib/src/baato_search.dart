import 'package:baato_api/baato_api.dart';
import 'package:baato_api/models/search.dart';
import 'package:dio/dio.dart';

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
  BaatoSearch.initialize(
      {required this.query,
      required this.accessToken,
      this.appId,
      this.securityCode,
      this.apiBaseUrl,
      this.apiVersion,
      this.type,
      this.limit,
      this.radius,
      this.lat,
      this.lon}) {
    _initializeDio();
  }

  /// Initialize Dio client for network requests
  void _initializeDio() {
    _client = Dio(BaseOptions(
        baseUrl: apiBaseUrl ?? "https://api.baato.io/api/v1/search"));
  }

  /// Search using baato API
  Future<SearchResponse> searchQuery() async {
    Map responseBody;
    SearchResponse returnable;
    try {
      final response = await _client.get(
          apiBaseUrl ?? "https://api.baato.io/api/v1/search",
          queryParameters: getQueryParams());
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

  Map<String, dynamic> getQueryParams() {
    var queryParams = {"key": accessToken, "q": query};
    if (type != null) queryParams['type'] = type!;
    if (radius != null) queryParams['radius'] = radius.toString();
    if (limit != null) queryParams['limit'] = limit.toString();
    if (lat != null) queryParams['lat'] = lat.toString();
    if (lon != null) queryParams['lon'] = lon.toString();
    if (appId != null && securityCode != null)
      queryParams['hash'] = BaatoUtils()
          .generateHash(appId.toString(), accessToken, securityCode.toString());
    return queryParams;
  }
}
