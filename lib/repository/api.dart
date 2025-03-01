import 'package:dio/dio.dart';

class Api {
  static final Dio _dio = Dio();

  Api() {
    _dio.options.followRedirects = false;
    // _dio.options.baseUrl = "https://aeci.emziniafrica.com/";
  }

  Dio get sendRequest => _dio;
}
