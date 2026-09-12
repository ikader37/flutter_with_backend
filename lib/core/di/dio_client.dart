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
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print('[DIO] --> ${options.method} ${options.path}');

          final token = await storage.read(
            key: 'access_token',
          );

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },

        onResponse: (response, handler) {
          print('[DIO] <-- ${response.statusCode}');
          handler.next(response);
        },

        onError: (e, handler) async {
          print(
            '[DIO] ERREUR : ${e.type} - ${e.message}',
          );

          if (e.response?.statusCode == 401) {
            await storage.deleteAll();
          }

          handler.next(e);
        },
      ),
    );
  }
}