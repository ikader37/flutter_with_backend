import 'package:app_test_with_backend/features/login/data/models/UserModel.dart';
import 'package:app_test_with_backend/features/login/domain/entities/UserEntity.dart';
import 'package:app_test_with_backend/features/login/domain/usecases/Login_use_case.dart';
import 'package:app_test_with_backend/features/login/domain/usecases/profile_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final GetProfilUseCase getProfilUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.getProfilUseCase
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<GetProfilEvent>(_onGetProfilRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      final user = await loginUseCase(LoginParams(email: event.email, password: event.password));

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event,
      Emitter<AuthState> emit,
      ) async {

    emit(AuthUnauthenticated());
  }

  Future<void> _onGetProfilRequested(
      GetProfilEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try{
    final user= await getProfilUseCase();
    emit(GetProfilState(user));
  }catch(e){
    emit(AuthError(e.toString()));
  }
  }
}