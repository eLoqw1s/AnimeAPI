import 'dart:async';
abstract class AuthServiceInterface {
  Future<void> signUp({required String email, required String password});
  Future<void> logIn({required String email, required String password});
  Future<void> logOut();
}