import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymapp/Pages/RequestPage.dart';
import 'package:gymapp/Pages/ShowHistory.dart';
import 'package:gymapp/Pages/ShowWorkouts.dart';
import 'package:gymapp/Pages/UserSettings.dart';
import 'package:gymapp/Pages/loginPage.dart';
import 'package:gymapp/Pages/updatepassword.dart';
import 'package:gymapp/provider/provider.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import 'Pages/ShowDietPage.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ShowWorkouts(id: 12));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
