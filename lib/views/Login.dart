import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/material.dart';
import 'package:project/resources/Strings.dart';
import 'package:project/widgets/CustomButton.dart';
import 'package:project/widgets/CustomCheckBox.dart';
import 'package:project/widgets/CustomTextField.dart';
import 'package:project/widgets/CustomTextLink.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  bool logoVisible = true;
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    const logoField = Image(image: AssetImage('assets/images/logo.png'));
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
          ),
          onPressed: () {
            setState(() {
              hidePass = !hidePass;
            });
          }),
    );

    final rememberField = TextCheckbox(
      textStyle: style.copyWith(color: Colors.black, fontSize: 15),
      text: Strings.rememberMe,
    );

    final forgotPasswordField = PartialLinkText(
      linkText: Strings.forgotPassword,
      fontSize: 15,
      onLinkClickedCallback: () {
        Navigator.pushNamed(context, "/forgotPass");
      },
    );

    final loginButton = IconWithTextButton(
      text: Strings.login,
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

    final loginGoogleButton = IconWithTextButton(
      text: Strings.googleLogin,
      textAlign: TextAlign.center,
      buttonWidth: 160,
      color: Colors.red,
      gradientColor: const [Colors.transparent],
      borderRadius: 50,
      iconSize: 20,
      iconData: FontAwesomeIcons.google,
      textStyle:
      style.copyWith(color: Colors.white),
      onPressedCallback: () {
        Navigator.pushNamed(context, "/homepage");
      },
    );

    final loginFacebookButton = IconWithTextButton(
      text: Strings.facebookLogin,
      textAlign: TextAlign.center,
      buttonWidth: 160,
      borderRadius: 50,
      iconSize: 20,
      iconData: Icons.facebook,
      color: Colors.blue,
      textStyle:
      style.copyWith(color: Colors.white),
      onPressedCallback: () {
        Navigator.pushNamed(context, "/homepage");
      },
    );

    final signupTextField = PartialLinkText(
      normalText: Strings.toSignUpNormalText,
      linkText: Strings.signUp,
      fontSize: 18,
      onLinkClickedCallback: () {
        Navigator.pushNamed(context, "/signUp");
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
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 30.0),
                        Visibility(visible: logoVisible, child: logoField)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 30.0),
                        usernameField,
                        const SizedBox(height: 20.0),
                        passwordField
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
                            padding:
                                const EdgeInsets.fromLTRB(50.0, 20, 50.0, 0),
                            child: loginButton),
                        forgotPasswordField
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding:
                            const EdgeInsets.fromLTRB(10.0, 50, 10.0, 0),
                            child: loginGoogleButton,

                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(10, 50, 10.0, 0),
                          child: loginFacebookButton,
                        ),
                      ],
                    ),
                    const Expanded(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Divider(
                        color: Colors.black,
                        height: 0,
                        thickness: 1,
                        indent: 150,
                        endIndent: 150,
                      ),
                    )),
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[signupTextField],
                            )))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
