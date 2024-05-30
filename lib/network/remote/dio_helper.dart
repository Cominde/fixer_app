import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fixer-backend-rtw4.onrender.com/api/V1/auth/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json',},
      ),
    );
  }

  static Future<Response> getData(
      String url, Map<String, dynamic> query) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postDate({
    required String url,
    required Map<String, dynamic> data,
  }) async {

    return await dio.post(url, data: data,);
  }

}
