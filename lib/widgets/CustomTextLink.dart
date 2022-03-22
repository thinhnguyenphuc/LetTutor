import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PartialLinkText extends StatelessWidget {
  final String normalText;
  final String linkText;
  final double fontSize;
  final Color color;
  final void Function()? onLinkClickedCallback;

  ///Create a normal text continues with a link text
  ///
  const PartialLinkText({
    Key? key,
    this.normalText = "",
    this.linkText = "",
    this.fontSize = 18,
    this.onLinkClickedCallback,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            normalText,
            style: TextStyle(fontSize: fontSize, color: color),
          ),
          TextButton(
              onPressed: onLinkClickedCallback,
              child: Text(linkText,
                  style: TextStyle(
                      color: color,
                      fontSize: fontSize,
                      decoration: TextDecoration.underline)))
        ]));
  }
}
