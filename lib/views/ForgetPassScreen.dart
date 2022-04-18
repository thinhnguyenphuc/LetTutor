import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:project/resources/Strings.dart';
import 'package:project/widgets/CustomButton.dart';
import 'package:project/widgets/CustomTextField.dart';
import 'package:project/widgets/HeroAnimation.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({Key? key}) : super(key: key);

  @override
  _ForgetPassPageState createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    Future<void> forgotPassword() async {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data', textAlign: TextAlign.center,),
        backgroundColor: Colors.green.shade300,
      ));
    }


    final logoField = IconHero(
        tag: "logo",
        child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
          return AnimatedContainer(
            width: !isKeyboardVisible
                ? MediaQuery.of(context).size.width / 1.5
                : MediaQuery.of(context).size.width / 2,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: Image.asset("assets/images/logo.png"),
          );
        }));

    final resetPassText = Text(Strings.resetPassword,
    style: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ));

    final resetPassContentText = Text(Strings.resetPasswordContent,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
        ));

    final emailField = IconInputField(
      iconData: Icons.email,
      hintText: Strings.email,
      autoFocus: false,
    );

    final forgetPassButton = IconWithTextButton(
      text: Strings.sendResetLink,
      textAlign: TextAlign.center,
      buttonWidth: MediaQuery.of(context).size.width / 2,
      borderRadius: 50,
      iconSize: 20,
      hasGradientColor: true,
      textStyle:
      style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      onPressedCallback: forgotPassword,
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
              color: const Color(0xFF262626),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[logoField],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,10,10,50),
                      child: Column(
                        children: [
                          resetPassText,
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,20,0,0),
                            child: Column(
                              children: [
                                resetPassContentText
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        emailField,
                      ],
                    ),
                    const Spacer(),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[forgetPassButton],
                            ))),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
