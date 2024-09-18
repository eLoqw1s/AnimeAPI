import 'package:flutter/material.dart';
import 'package:android_dev/app/app.dart';
class AndroidDevApp extends StatelessWidget {
 const AndroidDevApp({super.key});
 @override
 Widget build(BuildContext context) {
  return MaterialApp.router(
    title: 'Android Dev',
    theme: AppTheme.lightTheme,
    routeInformationProvider: router.routeInformationProvider,
    routeInformationParser: router.routeInformationParser,
    routerDelegate: router.routerDelegate,
    debugShowCheckedModeBanner: false,
  );
 }
}