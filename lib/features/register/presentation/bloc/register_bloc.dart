import 'package:app_test_with_backend/features/login/domain/usecases/Login_use_case.dart';
import 'package:app_test_with_backend/features/register/domain/usecases/register_use_case.dart';
import 'package:app_test_with_backend/features/register/presentation/bloc/register_event.dart';
import 'package:app_test_with_backend/features/register/presentation/bloc/register_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({
    required this.registerUseCase,
  }) : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onRegisterRequested(
      RegisterRequested event,
      Emitter<RegisterState> emit,
      ) async {
    emit(RegisterLoading());

    try {
      final user = await registerUseCase(RegisterParams(email: event.email, password: event.password,name:event.name));

      emit(RegisteredUser(user));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

}