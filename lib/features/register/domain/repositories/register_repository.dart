import 'package:app_test_with_backend/features/login/domain/entities/UserEntity.dart';

abstract class RegisterRepository {
  Future<UserEntity> register(String email, String password,String name);

}
