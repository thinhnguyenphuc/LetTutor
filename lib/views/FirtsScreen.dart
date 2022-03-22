import 'package:flutter/material.dart';
import 'package:project/resources/Strings.dart';
import 'package:project/resources/routes.dart';
import 'package:project/views/Login.dart';
import 'package:project/widgets/CustomButton.dart';

import 'Register.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstScreen> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);


  final welcomeText = Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Text.rich(
        TextSpan(style: TextStyle(fontSize: 20), text: 'WELCOME TO'),
      ),
      Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: ' LET TUTOR ',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            TextSpan(text: 'APP', style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    ],
  );


  @override
  Widget build(BuildContext context) {
    const logoField = Image(image: AssetImage('assets/images/logo.png'));

    final loginButton = IconWithTextButton(
      text: Strings.login,
      textAlign: TextAlign.center,
      buttonWidth: 200,
      borderRadius: 50,
      iconSize: 20,
      hasGradientColor: true,
      color: Colors.white,
      gradientColor: const [Colors.pink, Colors.purple],
      textStyle: style.copyWith(color: Colors.white),
      onPressedCallback: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
      },
    );

    final signUpButton = IconWithTextButton(
      text: Strings.signUp,
      textAlign: TextAlign.center,
      buttonWidth: 200,
      borderRadius: 50,
      iconSize: 20,
      hasGradientColor: true,
      gradientColor: const [Colors.purple, Colors.pinkAccent],
      color: Colors.white,
      textStyle: style.copyWith(color: Colors.white),
      onPressedCallback: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterPage()));
      },
    );

    const signatureText = Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: ' Design and copyright by ',
          ),
          TextSpan(text: 'ThinhNguyen', style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 15)),
        ],
      ),
    );

    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.lightBlue,
                      Colors.lightBlueAccent,
                      Colors.greenAccent,
                      Colors.green,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 30.0),
                        logoField,
                        welcomeText
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding:
                            const EdgeInsets.fromLTRB(50.0, 100, 50.0, 0),
                            child: loginButton),
                        Padding(
                            padding:
                            const EdgeInsets.fromLTRB(50.0, 20, 50.0, 0),
                            child: signUpButton),
                      ],
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                signatureText
                              ],
                            )))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
