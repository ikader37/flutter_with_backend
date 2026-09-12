import 'package:app_test_with_backend/features/login/domain/entities/UserEntity.dart';
import 'package:equatable/equatable.dart';


sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisteredUser extends RegisterState {
  final UserEntity user;
  const RegisteredUser(this.user);
  @override
  List<Object?> get props => [user];
}
class UnRegisteredUser extends RegisterState {}
class RegisterError extends RegisterState {
  final String message;
  const RegisterError(this.message);
  @override
  List<Object?> get props => [message];
}