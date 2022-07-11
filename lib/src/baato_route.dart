import 'package:baato_api/models/route.dart';
import 'package:dio/dio.dart';

class BaatoRoute {
  String accessToken;
  String? apiVersion = "1";
  String? apiBaseUrl;
  String mode;
  List points;
  bool? alternatives;
  bool? instructions;
  late Dio _client;

  /// To initialize Baato Route API parameters
  /// using [mode],[points] and [accessToken]
  BaatoRoute.initialize(
      {required this.accessToken,
      required this.mode,
      required this.points,
      this.apiBaseUrl,
      this.apiVersion,
      this.instructions,
      this.alternatives}) {
    _initializeDio();
  }

  /// Initialize Dio client for network requests
  void _initializeDio() {
    _client = Dio(BaseOptions(
        baseUrl: apiBaseUrl ?? "https://api.baato.io/api/v1/directions"));
  }

  /// Routing using baato API
  Future<RouteResponse> getRoutes() async {
    Map responseBody;
    RouteResponse returnable;
    try {
      final response = await _client.get(
          apiBaseUrl ?? "https://api.baato.io/api/v1/directions",
          queryParameters: getQueryParams());
      responseBody = response.data;
      returnable = RouteResponse.fromJson(responseBody);
    } on DioError catch (error) {
      if (error.response != null) {
        var response = error.response;
        responseBody = response?.data;
        throw Exception(response);
      } else {
        throw Exception("Failed to send Route request");
      }
    }
    return returnable;
  }

  Map<String, dynamic> getQueryParams() {
    var queryParams = {'key': accessToken, "mode": mode, "points[]": points};
    if (alternatives != null) queryParams['alternatives'] = alternatives!;
    if (instructions != null) queryParams['instructions'] = instructions!;
    return queryParams;
  }
}
