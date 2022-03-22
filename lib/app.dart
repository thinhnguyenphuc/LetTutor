
import 'package:flutter/material.dart';
import 'package:project/resources/Strings.dart';
import 'package:project/resources/routes.dart';
import 'package:project/views/Login.dart';
import 'package:project/views/Splash.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      initialRoute: "/",
      routes: {
        '/': (context) => const SplashScreen(),
        Routes.login: (context) => const LoginPage(),
        Routes.signUp: (context) => const SplashScreen(),
      },
    );
  }
}