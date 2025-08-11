import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoInterceptors extends Interceptor {
  const PackageInfoInterceptors(this.appId);
  final String? appId;

  static String? _appId;
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (appId != null) {
      _appId = appId;
    } 
    else if (_appId == null && appId == null) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      _appId = packageInfo.packageName;
    }
    options.queryParameters.addAll({
      'app_id': _appId,
    });

    super.onRequest(options, handler);
  }
}

class KeyHashInterceptors extends Interceptor {
  const KeyHashInterceptors(this.securityCode, this.apiKey);
  final String? securityCode;
  final String apiKey;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final appId = PackageInfoInterceptors._appId;

    options.queryParameters.addAll({'key': apiKey});

    if (appId != null && securityCode != null) {
      options.queryParameters.addAll({
        'hash': _generateHash(appId, apiKey, securityCode!),
      });
    }
    super.onRequest(options, handler);
  }

  String _generateHash(String appId, String accessToken, String securityCode) {
    var key = utf8.encode(securityCode);
    var messageBytes = utf8.encode(appId + accessToken);

    Hmac hmac = new Hmac(sha512, key);
    Digest digest = hmac.convert(messageBytes);

    return digest.toString();
  }
}
