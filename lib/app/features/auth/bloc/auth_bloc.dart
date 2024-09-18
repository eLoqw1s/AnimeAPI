import 'package:android_dev/di/di.dart';
import 'package:equatable/equatable.dart';
import 'package:android_dev/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "auth_event.dart";
part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial())  {
    on<SignUpRequested>(_signUpRequested);
    on<LogInRequested>(_logInRequested);
    on<LogOutRequested>(_logOutRequested);
    on<ResetAuth>(_resetAuth);
  }

  Future<void> _resetAuth(
      ResetAuth event, Emitter<AuthState> emit) async {
    emit(AuthInProgress());
    try {
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(error: e.toString())); // Обработка ошибки, если необходимо
    }
  }

  Future<void> _signUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthInProgress());
    try {
      await authService.signUp(email: event.email, password: event.password);
      
      UserDataService userDataService = UserDataService();
      userDataService.addUserData(email: event.email, name: event.password);
      //
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _logInRequested(
      LogInRequested event, Emitter<AuthState> emit) async {
    emit(AuthInProgress());
    try {
      await authService.logIn(email: event.email, password: event.password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _logOutRequested(LogOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthInProgress());
    try {
      await authService.logOut();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
  
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}