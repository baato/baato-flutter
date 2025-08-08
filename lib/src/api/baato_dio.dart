import 'dart:convert';

import 'package:baato_api/src/api/baato_api_endpoints.dart';
import 'package:baato_api/src/api/interceptors.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

/// A utility class for handling HTTP requests to the Baato API
class BaatoDio {
  final String apiKey;
  final String apiBaseUrl;
  final String? appId;
  final String? securityCode;
  final String apiVersion;
  final int connectTimeoutInSeconds;
  final int receiveTimeoutInSeconds;
  final bool addLoggingInterceptor;

  late Dio _dio;

  /// Creates a new BaatoDio instance with the specified configuration
  ///
  /// [apiKey] - The API key for authentication
  /// [apiBaseUrl] - The base URL for the Baato API
  /// [appId] - Optional app ID for hash-based authentication
  /// [securityCode] - Optional security code for hash-based authentication
  /// [apiVersion] - The API version to use
  /// [connectTimeoutInSeconds] - The connection timeout in seconds
  /// [receiveTimeoutInSeconds] - The receive timeout in seconds
  /// [addLoggingInterceptor] - Whether to add a logging interceptor for debugging
  BaatoDio({
    required this.apiKey,
    required this.apiBaseUrl,
    required this.apiVersion,
    this.appId,
    this.securityCode,
    this.connectTimeoutInSeconds = 10,
    this.receiveTimeoutInSeconds = 10,
    this.addLoggingInterceptor = true,
  }) {
    _initializeDio();
  }

  /// Initializes the Dio client with the appropriate configuration
  void _initializeDio() {
    final fullBaseUrl = "$apiBaseUrl/$apiVersion";
    _dio = Dio(
      BaseOptions(
        baseUrl: fullBaseUrl,
        connectTimeout: Duration(seconds: connectTimeoutInSeconds),
        receiveTimeout: Duration(seconds: receiveTimeoutInSeconds),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    _dio.interceptors.add(PackageInfoInterceptors(appId));
    

    // Add logging interceptor for debugging
    if (addLoggingInterceptor) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          logPrint: (object) => print(object),
        ),
      );
    }
  }

  /// Performs a GET request to the specified endpoint
  ///
  /// [endpoint] - The API endpoint to call
  /// [queryParameters] - Optional query parameters to include in the request
  Future<Response> get(
    BaatoApiEndpoint endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      // Add API key to all requests
      final params = queryParameters ?? {};
      params['key'] = apiKey;

      // Add hash if appId and securityCode are provided
      if (appId != null && securityCode != null) {
        params['hash'] = _generateHash(appId!, apiKey, securityCode!);
      }

      final response = await _dio.get(endpoint.path, queryParameters: params);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Performs a POST request to the specified endpoint
  ///
  /// [endpoint] - The API endpoint to call
  /// [data] - The data to send in the request body
  /// [queryParameters] - Optional query parameters to include in the request
  Future<Response> post(
    BaatoApiEndpoint endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      // Add API key to all requests
      final params = queryParameters ?? {};
      params['key'] = apiKey;

      if (appId != null && securityCode != null) {
        params['hash'] = _generateHash(appId!, apiKey, securityCode!);
      }

      final response = await _dio.post(
        endpoint.path,
        data: data,
        queryParameters: params,
      );
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Handles errors from Dio requests
  void _handleError(DioException error) {
    if (error.response != null) {
      print('Error Status: ${error.response?.statusCode}');
      print('Error Data: ${error.response?.data}');
    } else {
      print('Error Message: ${error.message}');
    }
  }

  String _generateHash(String appId, String accessToken, String securityCode) {
    var key = utf8.encode(securityCode);
    var messageBytes = utf8.encode(appId + accessToken);

    Hmac hmac = new Hmac(sha512, key);
    Digest digest = hmac.convert(messageBytes);

    return digest.toString();
  }

  /// Returns the Dio instance for direct access if needed
  Dio get dio => _dio;
}
