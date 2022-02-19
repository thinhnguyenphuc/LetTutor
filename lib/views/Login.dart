import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/material.dart';
import 'package:project/resources/Strings.dart';
import 'package:project/widgets/CustomButton.dart';
import 'package:project/widgets/CustomCheckBox.dart';
import 'package:project/widgets/CustomTextField.dart';
import 'package:project/widgets/CustomTextLink.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  bool logoVisible = true;


  @override
  Widget build(BuildContext context) {
    const logoField = Image(image: AssetImage('assets/images/logo.png'));
    final usernameField = IconInputField(
      iconData: Icons.person,
      hintText: Strings.userName,
      autoFocus: false,
    );

    final passwordField = IconInputField(
      textObscured: true,
      iconData: Icons.vpn_key,
      hintText: Strings.password,
      autoFocus: false,
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
      color: const Color.fromARGB(255, 4, 148, 124),
      textAlign: TextAlign.center,
      textStyle: style.copyWith(
          color: Colors.white, fontWeight: FontWeight.bold),
      onPressedCallback: (){
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

    if(!(MediaQuery.of(context).viewInsets.bottom == 0.0)){
      setState(() {
        logoVisible = false;
      });
    } else {
      setState(() {
        logoVisible = true;
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          },
      child:
        Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 30.0),
                      Visibility(
                          visible: logoVisible,
                          child: logoField)
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
                            forgotPasswordField
                          ]
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(50.0,20,50.0,0),
                          child:
                          loginButton
                      ),
                      const Divider(
                        color: Colors.black,
                        height: 50,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ],
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        signupTextField
                      ]
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}