import 'package:flutter/material.dart';
import 'package:project/resources/Strings.dart';
import 'package:project/views/Login.dart';
import 'package:project/widgets/CustomButton.dart';
import 'package:project/widgets/HeroAnimation.dart';

import 'Register.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstScreen> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    const logoField = IconHero(
      tag: 'logo',
      child: Image(image: AssetImage('assets/images/logo.png')),
    );

    final loginButton = IconHero(
      tag: 'login',
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      },
      child: IconWithTextButton(
        text: Strings.login,
        textAlign: TextAlign.center,
        buttonWidth: 200,
        borderRadius: 50,
        iconSize: 20,
        hasGradientColor: true,
        color: Colors.white,
        gradientColor: const [Colors.brown, Colors.blueGrey],
        textStyle: style.copyWith(color: Colors.white),
      ),
    );

    final signUpButton = IconHero(
        tag: 'register',
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegisterPage()));
        },
        child: IconWithTextButton(
          text: Strings.signUp,
          textAlign: TextAlign.center,
          buttonWidth: 200,
          borderRadius: 50,
          iconSize: 20,
          hasGradientColor: true,
          gradientColor: const [Colors.blueGrey, Colors.grey],
          color: Colors.white,
          textStyle: style.copyWith(color: Colors.white),
        ));

    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
                image: const AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.black12,
                        Colors.black26,
                        Colors.black54,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.3, 0.6, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const <Widget>[logoField],
                              ))),
                      Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          50.0, 100, 50.0, 0),
                                      child: loginButton),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          50.0, 20, 50.0, 0),
                                      child: signUpButton),
                                ],
                              ))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
