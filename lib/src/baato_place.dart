import 'package:baato_api/models/place.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'exceptions.dart';

class BaatoPlace {
  String accessToken;
  String apiVersion = "1";
  String apiBaseUrl = "https://api.baato.io/api/v1/places";
  int placeId = 0;

  Dio _client;

  /// To initialize Baato Place API parameters
  /// using [placeId] and [accessToken]
  BaatoPlace.initialize({
    @required this.placeId,
    @required this.accessToken,
    this.apiBaseUrl = "https://api.baato.io/api/v1/places",
    this.apiVersion,
  }) {
    if (placeId == null) {
      throw IsNullException('The placeId cannot be null');
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

  /// Place Details using Baato API
  Future<PlaceResponse> getPlaceDetails() async {
    Map responseBody;
    PlaceResponse returnable;
    try {
      final response = await _client.get(apiBaseUrl,
          queryParameters: {"key": accessToken, "placeId": placeId});
      responseBody = response.data;
      returnable = PlaceResponse.fromJson(responseBody);
    } on DioError catch (error) {
      if (error.response != null) {
        var response = error.response;
        responseBody = response.data;
        throw Exception(responseBody['message']);
      } else {
        throw Exception("Failed to send place request");
      }
    }
    return returnable;
  }
}
