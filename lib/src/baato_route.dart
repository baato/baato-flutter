import 'package:baato_api/models/route.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'exceptions.dart';

class BaatoRoute {
  String accessToken;
  String apiVersion = "1";
  String apiBaseUrl = "https://api.baato.io/api/v1/directions";
  String mode;
  List points;
  bool alternatives;
  bool instructions;
  Dio _client;

  /// To initialize Baato Route API parameters
  /// using [mode],[points] and [accessToken]
  BaatoRoute.initialize(
      {@required this.accessToken,
      @required this.mode,
      @required this.points,
      this.apiBaseUrl = "https://api.baato.io/api/v1/directions",
      this.apiVersion,
      this.instructions,
      this.alternatives}) {
    if (mode == null) {
      throw IsNullException('The mode cannot be null');
    }
    if (points == null) {
      throw IsNullException('The points cannot be null');
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

  /// Routing using baato API
  Future<RouteResponse> getRoutes() async {
    Map responseBody;
    RouteResponse returnable;
    try {
      final response = await _client.get(apiBaseUrl, queryParameters: {
        "key": accessToken,
        "mode": mode,
        "alternatives": alternatives,
        "instructions": instructions,
        "points": points,
      });
      responseBody = response.data;
      returnable = RouteResponse.fromJson(responseBody);
    } on DioError catch (error) {
      if (error.response != null) {
        var response = error.response;
        responseBody = response.data;
        throw Exception(responseBody['message']);
      } else {
        throw Exception("Failed to send Route request");
      }
    }
    return returnable;
  }
}
