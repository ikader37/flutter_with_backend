import 'package:app_test_with_backend/core/errors/exceptions.dart';
import 'package:app_test_with_backend/features/login/domain/entities/UserEntity.dart';
import 'package:app_test_with_backend/features/login/domain/repositories/AuthRepositories.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

// Paramètres typés (évite les listes de paramètres primitifs)
class LoginParams {
  final String email;
  final String password;
  const LoginParams({required this.email, required this.password});
}

// Use Case typé
class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository _repository;
  const LoginUseCase(this._repository);


  @override
  Future<UserEntity> call(LoginParams params) async {
    if (params.password.length < 8) {
      throw const ValidationException('Mot de passe trop court');
    }
    return _repository.login(params.email, params.password);
  }
}