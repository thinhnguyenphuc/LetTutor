
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/resources/Strings.dart';
import 'package:project/views/Login.dart';
import 'package:project/views/Splash.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      title: Strings.appName,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}