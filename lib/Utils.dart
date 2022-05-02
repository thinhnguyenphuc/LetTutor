import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
class Utils {
  static void showSnackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
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

  static DateTime parseString(String str) {
    return DateFormat("hh:mm").parse(str);
  }

  static DateTime combineDateTime(DateTime date, DateTime time) {
    DateTime result = DateFormat("dd-MM-yyyy HH:mm").parse(
        date.day.toString()+"-"+
            date.month.toString()+"-"+
            date.year.toString()+" "+
            time.hour.toString()+":"+
            time.minute.toString()
    );
    return result;
  }
}
