import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    Dio(BaseOptions(
      baseUrl: 'https://gnews.io/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
