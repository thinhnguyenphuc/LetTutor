import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:project/views/FirtsScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Clean Code',
        localizationsDelegates: const [
          LocaleNamesLocalizationsDelegate(),
        ],
        home: AnimatedSplashScreen(
            duration: 2000,
            splash: Image.asset('assets/images/logo.png'),
            splashIconSize: 500,
            nextScreen: const FirstScreen(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.black54));
  }
}
