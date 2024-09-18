import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:android_dev/domain/domain.dart';
class AuthService extends AuthServiceInterface {
  AuthService({required this.dio});
  final Dio dio;
  @override
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }
  @override
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }
  @override
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }
}