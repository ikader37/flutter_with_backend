import 'package:app_test_with_backend/core/errors/exceptions.dart';
import 'package:app_test_with_backend/features/login/domain/entities/UserEntity.dart';
import 'package:app_test_with_backend/features/register/domain/repositories/register_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

// Paramètres typés (évite les listes de paramètres primitifs)
class RegisterParams {
  final String email;
  final String password;
  final String name;
  const RegisterParams({required this.email,
    required this.password,required this.name});
}

// Use Case typé
class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final RegisterRepository _repository;
  const RegisterUseCase(this._repository);


  @override
  Future<UserEntity> call(RegisterParams params) async {
    if (params.password.length < 8) {
      throw const ValidationException('Mot de passe trop court');
    }if(params.name==null || params.email.isEmpty){
      throw ValidationException("Le nom est obligatoire");
    }
    return _repository.register(params.email, params.password,params.name);
  }
}