import 'package:app_test_with_backend/features/login/domain/entities/UserEntity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<void> logout();
  Future<UserEntity> getProfile();
  Stream<UserEntity> get authStateChanges;
}