import 'package:dio/dio.dart';
import 'package:insta_clone/utils/contstants.dart';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.options
      ..baseUrl = Constanst.baseurl
      ..connectTimeout = const Duration(seconds: 10) // Connection timeout
      ..receiveTimeout = const Duration(seconds: 15); // Response timeout
  }

  Future<Response<dynamic>> getRequest(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      rethrow;
    } catch (e) {
      print('Exception: $e');
      rethrow;
    }
  }
}
