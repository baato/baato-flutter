import 'package:baato_api/models/route.dart';
import 'package:dio/dio.dart';

import '../baato_api.dart';

class BaatoRoute {
  String accessToken;
  String? apiVersion = "1";
  String apiBaseUrl = "https://api.baato.io/api/v1/directions";
  String mode;
  List points;
  String? appId;
  String? securityCode;
  bool? alternatives;
  bool? instructions;
  late Dio _client;

  /// To initialize Baato Route API parameters
  /// using [mode],[points] and [accessToken]
  BaatoRoute.initialize(
      {required this.accessToken,
      required this.mode,
      required this.points,
      this.appId,
      this.securityCode,
      this.apiBaseUrl = "https://api.baato.io/api/v1/directions",
      this.apiVersion,
      this.instructions,
      this.alternatives}) {
    _initializeDio();
  }

  /// Initialize Dio client for network requests
  void _initializeDio() {
    _client = Dio(BaseOptions(baseUrl: apiBaseUrl));
  }

  /// Routing using baato API
  Future<RouteResponse> getRoutes() async {
    Map? responseBody;
    RouteResponse returnable;
    try {
      final response =
          await _client.get(apiBaseUrl, queryParameters: getQueryParams());
      responseBody = response.data;
      returnable = RouteResponse.fromJson(responseBody);
    } on DioError catch (error) {
      if (error.response != null) {
        var response = error.response!;
        responseBody = response.data;
        throw Exception(responseBody!['message']);
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
    if (appId != null && securityCode != null)
      queryParams['hash'] = BaatoUtils()
          .generateHash(appId.toString(), accessToken, securityCode.toString());
    return queryParams;
  }
}
