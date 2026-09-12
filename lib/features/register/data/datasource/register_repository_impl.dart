import 'package:app_test_with_backend/features/login/domain/entities/UserEntity.dart';
import 'package:app_test_with_backend/features/register/data/datasource/interfaces/remote_register_data_source.dart';
import 'package:app_test_with_backend/features/register/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository{

  final RemoteRegisterDataSource _registerDataSource;
  const RegisterRepositoryImpl({required RemoteRegisterDataSource remoteRegister}):_registerDataSource=remoteRegister;
  @override
  Future<UserEntity> register(String email, String password, String name) async {
    // TODO: implement register
     final user=_registerDataSource.register(email, password, name);
     return UserEntity(email: email, name: name, password: password);
  }
}