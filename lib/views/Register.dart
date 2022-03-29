import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:project/resources/strings.dart';
import 'package:project/widgets/CustomButton.dart';
import 'package:project/widgets/CustomCheckBox.dart';
import 'package:project/widgets/CustomTextField.dart';
import 'package:project/widgets/CustomTextLink.dart';
import 'package:project/widgets/HeroAnimation.dart';

import 'Login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
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
      })
    );

    final emailField = IconInputField(
      iconData: Icons.email,
      hintText: Strings.email,
      autoFocus: false,
    );

    final usernameField = IconInputField(
      iconData: Icons.person,
      hintText: Strings.userName,
      autoFocus: false,
    );

    final passwordField = IconInputField(
      textObscured: hidePass,
      iconData: Icons.vpn_key,
      hintText: Strings.password,
      autoFocus: false,
      passField: true,
      hidePassButton: IconButton(
          icon: Icon(
            hidePass ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              hidePass = !hidePass;
            });
          }),
    );

    final rePasswordField = IconInputField(
      textObscured: hidePass,
      iconData: Icons.vpn_key,
      hintText: Strings.rePassword,
      autoFocus: false,
      passField: true,
      hidePassButton: IconButton(
          icon: Icon(
            hidePass ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              hidePass = !hidePass;
            });
          }),
    );

    final rememberField = TextCheckbox(
      textStyle: style.copyWith(color: Colors.white, fontSize: 15),
      text: Strings.rememberMe,
    );

    final forgotPasswordField = PartialLinkText(
      linkText: Strings.forgotPassword,
      color: Colors.white,
      fontSize: 15,
      onLinkClickedCallback: () {
        Navigator.pushNamed(context, '/login');
      },
    );

    final registerButton = IconWithTextButton(
      text: Strings.signUp,
      textAlign: TextAlign.center,
      buttonWidth: 200,
      borderRadius: 50,
      iconSize: 20,
      hasGradientColor: true,
      textStyle:
      style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      onPressedCallback: () {
        Navigator.pushNamed(context, "/homepage");
      },
    );

    final loginTextField = PartialLinkText(
      color: Colors.white,
      normalText: Strings.toLoginNormalText,
      linkText: Strings.login,
      fontSize: 18,
      onLinkClickedCallback: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      },
    );

    return
      Scaffold(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        emailField,
                        const SizedBox(height: 10.0),
                        usernameField,
                        const SizedBox(height: 10.0),
                        passwordField,
                        const SizedBox(height: 10.0),
                        rePasswordField,
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding:
                            const EdgeInsets.fromLTRB(50.0, 50, 50.0, 0),
                            child: IconHero(
                              tag: 'register',
                              onTap: () {

                              },
                              child: registerButton,
                            )),
                      ],
                    ),
                    const Spacer(),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[loginTextField],
                            ))),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}