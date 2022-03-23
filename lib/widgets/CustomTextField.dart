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
  final bool passField;
  final IconButton? hidePassButton;

  ///Create an rounded border input field with a prefix icon
  ///
  const IconInputField({
    Key? key,
    this.style = const TextStyle(
        fontFamily: 'Montserrat', fontSize: 16.0, color: Colors.white),
    this.textObscured = false,
    this.prefixIconPadding =
        const EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 10),
    this.contentPadding = const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
    this.iconData,
    this.hintText = "",
    this.borderRadius = 32.0,
    this.iconSize = 24,
    this.iconColor = const Color(0xFFE5F5F5),
    this.textEditingController,
    this.autoFocus = false,
    this.passField = false,
    this.hidePassButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focusBorder = OutlineInputBorder(
        borderSide: BorderSide(color: iconColor),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)));

    final enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: iconColor),
    borderRadius: BorderRadius.all(Radius.circular(borderRadius)));

    final decoratePass = InputDecoration(
      prefixIcon: Padding(
        padding: prefixIconPadding,
        child: Icon(
          iconData,
          color: iconColor,
          size: iconSize,
        ),
      ),
      suffixIcon: hidePassButton,
      contentPadding: contentPadding,
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      focusedBorder: focusBorder,
      enabledBorder: enabledBorder,

    );

    final decorate = InputDecoration(
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
      hintStyle: const TextStyle(color: Colors.grey),
      focusedBorder: focusBorder,
      enabledBorder: enabledBorder,
    );

    return TextField(
      autofocus: autoFocus,
      controller: textEditingController,
      obscureText: textObscured,
      style: style,
      decoration: passField ? decoratePass : decorate,
    );
  }
}
