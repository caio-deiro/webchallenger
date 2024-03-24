import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class DioService extends DioForBrowser {
  DioService() : super() {
    super.options.baseUrl = 'http://digital-aligner.ddns.net:3000';
    super.httpClientAdapter = BrowserHttpClientAdapter();
    super.interceptors.add(DioServiceInterceptor());
  }
  String? token;
  String? userId;
}

class DioServiceInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final dioService = GetIt.I.get<DioService>();
    options.headers.addAll({
      "Content-Type": "Application/Json",
    });

    if (dioService.token != null) {
      options.headers.addAll({
        "Authorization": "Bearer ${dioService.token}",
      });
    }
    return super.onRequest(options, handler);
  }
}
