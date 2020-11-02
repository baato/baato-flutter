import 'package:baato_api/models/place.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'exceptions.dart';

class BaatoReverse {
  String accessToken;
  String apiVersion = "1";
  String apiBaseUrl = "https://api.baato.io/api/v1/reverse";
  int radius;
  GeoCoord latLon;

  Dio _client;

  /// To initialize Baato Reverse API parameters
  /// using [latLon] and [accessToken]
  BaatoReverse.initialize({
    @required this.latLon,
    @required this.accessToken,
    this.apiBaseUrl = "https://api.baato.io/api/v1/reverse",
    this.apiVersion,
    this.radius,
  }) {
    if (latLon == null) {
      throw IsNullException('The latLon cannot be null');
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

  /// Reverse Search in baato
  Future<PlaceResponse> reverseGeocode() async {
    Map responseBody;
    PlaceResponse returnable;
    try {
      final response =
          await _client.get(apiBaseUrl, queryParameters: getQueryParams());
      responseBody = response.data;
      returnable = PlaceResponse.fromJson(responseBody);
    } on DioError catch (error) {
      if (error.response != null) {
        var response = error.response;
        responseBody = response.data;
        throw Exception(responseBody['message']);
      } else {
        throw Exception("Failed to send Reverse request");
      }
    }
    return returnable;
  }

  Map<String, dynamic> getQueryParams() {
    var queryParams = {
      "key": accessToken,
      "lat": latLon.lat,
      "lon": latLon.lon
    };
    if (radius != null) queryParams['radius'] = radius;
    return queryParams;
  }
}
