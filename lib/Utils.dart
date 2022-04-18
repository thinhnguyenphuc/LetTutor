import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class Utils{
  static void showSnackBar(BuildContext context,String text, Color color){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, textAlign: TextAlign.center,),
      backgroundColor: color,
    ));
}

  static Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
    throw 'Could not launch $url';
    }
  }
}