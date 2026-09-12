import 'package:app_test_with_backend/features/login/domain/entities/UserEntity.dart';
import 'package:app_test_with_backend/features/login/domain/repositories/AuthRepositories.dart';

abstract class UseCase<Type> {
  Future<Type> call();
}
class GetProfilUseCase implements UseCase<UserEntity>{
  final AuthRepository _repository;
  const GetProfilUseCase(this._repository);

  @override
  Future<UserEntity> call() async{
    return this._repository.getProfile();
  }


}