import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:android_dev/di/di.dart';
import 'package:android_dev/android_dev.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
      apiKey: "",
      appId: "",
      messagingSenderId: "",
      projectId: ""
    ));
  } else {
    await Firebase.initializeApp();
  }

  setupLocator();
  FlutterError.onError = (details) => talker.handle(
    details.exception,
    details.stack,
  );
  runApp(const AndroidDevApp());
}
