import 'package:baato_api/models/place.dart';
import 'package:dio/dio.dart';
import '../baato_api.dart';

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
  void _initializeDio() {
    _client = Dio(BaseOptions(
        baseUrl: apiBaseUrl ?? "https://api.baato.io/api/v1/places"));
  }

  /// Place Details using Baato API
  Future<PlaceResponse> getPlaceDetails() async {
    Map responseBody;
    PlaceResponse returnable;
    try {
      final response = await _client.get(
          apiBaseUrl ?? "https://api.baato.io/api/v1/places",
          queryParameters: getQueryParams());
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

  Map<String, dynamic> getQueryParams() {
    var queryParams = {"key": accessToken, "placeId": placeId};
    if (appId != null && securityCode != null)
      queryParams['hash'] = BaatoUtils()
          .generateHash(appId.toString(), accessToken, securityCode.toString());
    return queryParams;
  }
}
