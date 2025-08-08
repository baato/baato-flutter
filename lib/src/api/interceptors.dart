import 'package:dio/dio.dart';
// import 'package:package_info_plus/package_info_plus.dart';

String? _appId;

class PackageInfoInterceptors extends Interceptor {
  const PackageInfoInterceptors(this.appId);
  final String? appId;
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (appId != null) {
      _appId = appId;
    }
    else if(_appId == null && appId == null) {
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // _appId = packageInfo.packageName;
    }
    options.queryParameters.addAll({
      'app_id': _appId,
    });

    super.onRequest(options, handler);
  }
}

