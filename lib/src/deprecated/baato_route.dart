import 'package:baato_api/src/deprecated/baato_utils.dart';
import 'package:baato_api/src/deprecated/route.dart';
import 'package:dio/dio.dart';

/// A class to interact with Baato Route API
///
/// Provides functionality to get route directions using Baato API
/// @deprecated This class is deprecated and will be removed in a future version
@deprecated
class BaatoRoute {
  String accessToken;
  String? apiVersion = "1";
  String? apiBaseUrl;
  String mode;
  List points;
  String? appId;
  String? securityCode;
  bool? alternatives;
  bool? instructions;
  late Dio _client;

  /// To initialize Baato Route API parameters
  /// using [mode],[points] and [accessToken]
  /// @deprecated This constructor is deprecated and will be removed in a future version
  @deprecated
  BaatoRoute.initialize({
    required this.accessToken,
    required this.mode,
    required this.points,
    this.appId,
    this.securityCode,
    this.apiBaseUrl,
    this.apiVersion,
    this.instructions,
    this.alternatives,
  }) {
    _initializeDio();
  }

  /// Initialize Dio client for network requests
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  void _initializeDio() {
    _client = Dio(
      BaseOptions(
        baseUrl: apiBaseUrl ?? "https://api.baato.io/api/v1/directions",
      ),
    );
  }

  /// Routing using baato API
  ///
  /// Fetches route directions from Baato API using the configured parameters
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  Future<RouteResponse> getRoutes() async {
    Map responseBody;
    RouteResponse returnable;
    try {
      final response = await _client.get(
        apiBaseUrl ?? "https://api.baato.io/api/v1/directions",
        queryParameters: getQueryParams(),
      );
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

  /// Builds query parameters for API requests
  ///
  /// Creates a map of query parameters including authentication details
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  Map<String, dynamic> getQueryParams() {
    var queryParams = {'key': accessToken, "mode": mode, "points[]": points};
    if (alternatives != null) queryParams['alternatives'] = alternatives!;
    if (instructions != null) queryParams['instructions'] = instructions!;
    if (appId != null && securityCode != null)
      queryParams['hash'] = BaatoUtils().generateHash(
        appId.toString(),
        accessToken,
        securityCode.toString(),
      );
    return queryParams;
  }
}
