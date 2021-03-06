import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:project/resources/Strings.dart';
import 'package:project/widgets/CustomButton.dart';
import 'package:project/widgets/CustomTextField.dart';
import 'package:project/widgets/CustomTextLink.dart';
import 'package:project/widgets/HeroAnimation.dart';

import '../../Utils.dart';
import '../../models/ServiceMessageModel.dart';
import '../../view_models/RegisterViewModel.dart';
import 'Login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  bool hidePass = true;
  final RegisterViewModel _registerViewModel = RegisterViewModel();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> registerUser() async {
      ServiceMessage res = await _registerViewModel.register(
        _emailController.text,
        _passwordController.text,
      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (res.statusCode == 201) {
        Utils.showSnackBar(context, Strings.sendEmailToConfirmation,
            Colors.lightGreenAccent.shade100);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        Utils.showSnackBar(context, res.message, Colors.red.shade300);
      }
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

    final emailField = IconInputField(
      iconData: Icons.email,
      hintText: Strings.email,
      autoFocus: false,
      textEditingController: _emailController,
    );

    final usernameField = IconInputField(
      iconData: Icons.person,
      hintText: Strings.userName,
      autoFocus: false,
      textEditingController: _usernameController,
    );

    final passwordField = IconInputField(
      textObscured: hidePass,
      iconData: Icons.vpn_key,
      hintText: Strings.password,
      autoFocus: false,
      passField: true,
      textEditingController: _passwordController,
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
      textEditingController: _rePasswordController,
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
        FocusManager.instance.primaryFocus?.unfocus();
        if (_usernameController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              Strings.userNameEmpty,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red.shade300,
          ));
        } else if (_passwordController.text != _rePasswordController.text) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              Strings.passwordAndRePasswordNotMatch,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red.shade300,
          ));
        } else {
          registerUser();
        }
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
                              onTap: () {},
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
