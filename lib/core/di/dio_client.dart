import 'package:app_test_with_backend/core/network/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  final FlutterSecureStorage storage;

  late final Dio dio;

  DioClient({
    required this.storage,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/v2/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      AuthInterceptor(
        storage: storage,
      ),
      );
  }
}