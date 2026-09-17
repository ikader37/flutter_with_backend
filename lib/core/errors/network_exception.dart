import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => message;
}

NetworkException handleNetworkException(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          'La connexion a pris trop de temps. Veuillez réessayer.',
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          'Impossible de se connecter à Internet. Vérifiez votre connexion.',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;

        if (statusCode == 401) {
          return NetworkException(
            'Votre session a expiré. Veuillez vous reconnecter.',
          );
        }

        if (statusCode == 404) {
          return NetworkException(
            'La ressource demandée est introuvable.',
          );
        }

        if (statusCode != null && statusCode >= 500) {
          return NetworkException(
            'Le serveur est temporairement indisponible.',
          );
        }

        return NetworkException(
          'Une erreur est survenue lors de la communication avec le serveur.',
        );

      case DioExceptionType.cancel:
        return NetworkException(
          'La requête a été annulée.',
        );

      default:
        return NetworkException(
          'Une erreur réseau est survenue. Veuillez réessayer.',
        );
    }
  }

  return NetworkException(
    'Une erreur inattendue est survenue.',
  );
}