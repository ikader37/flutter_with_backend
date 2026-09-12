
import 'package:app_test_with_backend/features/login/domain/repositories/AuthRepositories.dart';

abstract class UseCase<Type> {
  Future<Type> call();
}
class LogoutUsecase implements UseCase<void> {
  final AuthRepository _repository;
  const LogoutUsecase(this._repository);
  @override
  Future<void>  call() async{
    try
        {
          _repository.logout();

        }catch(e){
      throw Exception(e.toString());
    }
  }
}