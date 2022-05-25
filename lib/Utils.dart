import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/FeedBackModel.dart' as feed_back;

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

  static DateTime parseStringToHourMin(String str) {
    return DateFormat("hh:mm").parse(str);
  }

  static String parseDateToString(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:m').format(date);
  }

  static DateTime combineDateTime(DateTime date, DateTime time) {
    DateTime result = DateFormat("dd-MM-yyyy HH:mm").parse(
        "${date.day}-${date.month}-${date.year} ${time.hour}:${time.minute}");
    return result;
  }

  static void showReviewsDialog(
      BuildContext context, List<feed_back.Feedback> feedbacks) {
    feedbacks.sort((a, b) => a.createdAt.isAfter(b.createdAt) ? 1 : 0);
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 800,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: feedbacks.length,
              itemBuilder: (context, position) {
                final feed_back.Feedback feedback = feedbacks[position];
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 45,
                            child: ClipOval(
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: CachedNetworkImage(
                                  imageUrl: feedback.firstInfo!.avatar,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: feedback.createdAt
                                              .toIso8601String(),
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RatingBar.builder(
                                itemSize: 30,
                                initialRating: feedback.rating.toDouble(),
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (double value) {},
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: feedback.content,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
