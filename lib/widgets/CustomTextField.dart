import 'package:flutter/material.dart';

class IconInputField extends StatelessWidget {
  final TextStyle style;
  final bool textObscured;
  final EdgeInsetsGeometry prefixIconPadding;
  final EdgeInsetsGeometry contentPadding;
  final IconData? iconData;
  final double iconSize;
  final Color iconColor;
  final String hintText;
  final double borderRadius;
  final TextEditingController? textEditingController;
  final bool autoFocus;
  ///Create an rounded border input field with a prefix icon
  ///
  const IconInputField({Key? key,
    this.style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
    this.textObscured = false,
    this.prefixIconPadding = const EdgeInsets.only( top: 10, left: 0, right: 0, bottom: 10),
    this.contentPadding = const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
    this.iconData,
    this.hintText = "",
    this.borderRadius = 32.0,
    this.iconSize = 24,
    this.iconColor = Colors.black,
    this.textEditingController,
    this.autoFocus = false,
  }):
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      controller: textEditingController,
      obscureText: textObscured,
      style: style,
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: prefixIconPadding,
            child: Icon(
              iconData,
              color: iconColor,
              size: iconSize,
            ),
          ),
          contentPadding: contentPadding,
          hintText: hintText,
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius))),
    );

  }

}