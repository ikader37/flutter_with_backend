import 'package:app_test_with_backend/features/login/data/models/UserModel.dart';

abstract class RemoteAuthDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> logout();
  Future<UserModel> getProfil();
}
