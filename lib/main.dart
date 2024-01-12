import 'package:flutter/material.dart';
import 'package:gymapp/Pages/loginPage.dart';
import 'package:gymapp/Pages/main_page.dart';
import 'package:gymapp/provider/Uiprovider.dart';
import 'package:gymapp/provider/provider.dart';
import 'dart:io';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider()),
    ChangeNotifierProvider<Uiprovider>(create: (_) => Uiprovider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(id: 6),
    );
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
