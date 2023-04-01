import 'dart:io';

import 'package:flutter/material.dart';
import 'package:machine_test/provider/Item_provider.dart';
import 'package:provider/provider.dart';
import '../screens/home_page.dart';

import 'screens/local_db.dart';
import 'screens/login_page.dart';

void main() {
  runApp(const MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemProvider(),
      child: MaterialApp(
        title: 'Machine Test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const LoginPage(),
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          LocalItemList.routeName: (context) => const LocalItemList(),
        },
      ),
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
