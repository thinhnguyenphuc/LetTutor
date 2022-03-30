import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/resources/Strings.dart';
import 'package:project/widgets/CustomButton.dart';
import 'package:project/widgets/CustomCheckBox.dart';
import 'package:project/widgets/CustomTextField.dart';
import 'package:project/widgets/CustomTextLink.dart';
import 'package:project/widgets/HeroAnimation.dart';

import '../view_models/LoginViewModel.dart';
import 'Homepage.dart';
import 'Register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  bool hidePass = true;
  LoginViewModel loginViewModel = LoginViewModel();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> loginUsers() async {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      //get response from ApiClient
      bool res = await loginViewModel.login(
        usernameController.text,
        passwordController.text,
      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (res) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Error:'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }

    ;

    final logoField = IconHero(
      tag: 'logo',
      child: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return AnimatedContainer(
          width: !isKeyboardVisible
              ? MediaQuery.of(context).size.width / 1.25
              : MediaQuery.of(context).size.width / 2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: Image.asset("assets/images/logo.png"),
        );
      }),
    );

    final usernameField = IconInputField(
      textEditingController: usernameController,
      iconData: Icons.person,
      hintText: Strings.userName,
      autoFocus: false,
    );

    final passwordField = IconInputField(
      textEditingController: passwordController,
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

    final loginButton = IconWithTextButton(
      text: Strings.login,
      textAlign: TextAlign.center,
      buttonWidth: MediaQuery.of(context).size.width / 2,
      borderRadius: 50,
      iconSize: 20,
      hasGradientColor: true,
      textStyle:
          style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      onPressedCallback: loginUsers,
    );

    final loginGoogleButton = IconButton(
      onPressed: () {
        Navigator.pushNamed(context, "/homepage");
      },
      icon: const FaIcon(FontAwesomeIcons.google),
      color: Colors.red,
      iconSize: 30,
    );

    final loginFacebookButton = IconButton(
      onPressed: () {
        Navigator.pushNamed(context, "/homepage");
      },
      icon: const FaIcon(FontAwesomeIcons.facebook),
      color: Colors.blue,
      iconSize: 30,
    );

    final signupTextField = PartialLinkText(
      color: Colors.white,
      normalText: Strings.toSignUpNormalText,
      linkText: Strings.signUp,
      fontSize: 18,
      onLinkClickedCallback: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RegisterPage()));
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
                padding: const EdgeInsets.all(20.0),
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
                        usernameField,
                        const SizedBox(height: 20.0),
                        passwordField,
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              rememberField,
                            ])
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                50.0,
                                MediaQuery.of(context).size.height / 20,
                                50.0,
                                0),
                            child: IconHero(
                              tag: 'login',
                              onTap: () {},
                              child: loginButton,
                            )),
                        forgotPasswordField
                      ],
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                signupTextField,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 0, 5.0, 30),
                                      child: loginGoogleButton,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 5.0, 30),
                                      child: loginFacebookButton,
                                    ),
                                  ],
                                ),
                              ],
                            ))),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
