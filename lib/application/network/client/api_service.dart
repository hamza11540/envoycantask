import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../../../common/logger/log.dart';

import '../../../data/local_data_source/preference/iPrefHelper.dart';
import '../../../di/di.dart';
import '../external_values/iExternalValue.dart';
import 'iApService.dart';

class ApiService extends Interceptor implements IApiService {
  ApiService.create({required IExternalValues externalValues}) {
    serviceGenerator(externalValues);
  }

  @override
  Dio get() => _dio;

  @override
  BaseOptions getBaseOptions(IExternalValues externalValues) {
    return BaseOptions(
        baseUrl: externalValues.getBaseUrl(),
        receiveDataWhenStatusError: true,
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        connectTimeout: 60 * 1000,
        receiveTimeout: 60 * 1000);
  }

  @override
  HttpClient httpClientCreate(HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }

  @override
  void serviceGenerator(IExternalValues externalValues) {
    _dio = Dio(getBaseOptions(externalValues));
    _dio.interceptors.add(this);
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        httpClientCreate;
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // IPrefHelper prefHelper = inject<IPrefHelper>();
    // final token = prefHelper.retrieveAccessToken();

    if (options.path != '/api/login') {
      options.headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json",
        // HttpHeaders.authorizationHeader: "Bearer $token"
      };
      //d(token!);
    }

    d("onRequest");
    d('path: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    d("onResponse");
    d('status code: ${response.statusCode}');
    d('Response: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    d("onError");
    d('status code: ${err.response?.statusCode}');
    d('Response: ${err.response?.data}');
    return handler.next(err);
  }

  late Dio _dio;
}
