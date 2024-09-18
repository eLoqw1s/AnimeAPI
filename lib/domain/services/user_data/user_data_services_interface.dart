import 'dart:async';
import 'package:android_dev/domain/domain.dart';

abstract class UserDataServiceInterface {
  Future<UserData> getUserData();
  Future<void> addUserData({required String name, required String email});
  Future<void> updateUserData({required String name, required String description});
  Future<void> deleteUserData();
}