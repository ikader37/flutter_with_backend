import 'package:app_test_with_backend/features/login/data/datasource/interfaces/remote_auth_data_source.dart';
import 'package:app_test_with_backend/features/login/data/models/UserModel.dart';
import 'package:app_test_with_backend/features/login/domain/entities/UserEntity.dart';
import 'package:app_test_with_backend/features/login/domain/repositories/AuthRepositories.dart';

class Authrepositoryimpl implements AuthRepository{
  final RemoteAuthDataSource _remoteAuthDataSource;

  Authrepositoryimpl({required RemoteAuthDataSource remoteAuthDataSource}):_remoteAuthDataSource=remoteAuthDataSource;



  @override
  // TODO: implement authStateChanges
  Stream<UserEntity> get authStateChanges => throw UnimplementedError();

  @override
  Future<UserEntity> getProfile() async{
    return _remoteAuthDataSource.getProfil();
  }

  @override
  Future<UserEntity> login(String email, String password) async {
final UserModel userModel=await _remoteAuthDataSource.login(email, password);
return userModel.toEntity();

  }

  @override
  Future<void> logout() async {
    _remoteAuthDataSource.logout();
  }

}