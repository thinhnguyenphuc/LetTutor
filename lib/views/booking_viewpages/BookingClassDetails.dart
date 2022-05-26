import 'package:cached_network_image/cached_network_image.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:project/Utils.dart';
import 'package:project/models/ScheduleDetailsModel.dart';
import 'package:project/models/TutorModel.dart';
import 'package:project/resources/CountryList.dart';
import 'package:project/view_models/BookingViewModel.dart';

class BookingClassDetails extends StatefulWidget {
  final List<ScheduleDetailInfo> schedules;
  final TutorInfo tutor;

  const BookingClassDetails({
    Key? key,
    required this.schedules,
    required this.tutor,
  }) : super(key: key);

  @override
  BookingClassDetailsState createState() => BookingClassDetailsState();
}

class BookingClassDetailsState extends State<BookingClassDetails> {
  final BookingViewModel _bookingViewModel = BookingViewModel();
  late String chosenID = "";
  TextStyle style = const TextStyle(fontSize: 20, color: Colors.black);
  TextStyle titleStyle = const TextStyle(fontSize: 40, color: Colors.black);
  TextStyle buttonTextStyle =
      const TextStyle(fontSize: 20, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    widget.schedules.sort(
        (a, b) => a.startPeriodTimestamp.compareTo(b.startPeriodTimestamp));

    var countryName = CountrySingleton().countryHashMap[widget.tutor.country];
    final localNameView = countryName != null
        ? Text(
            countryName,
            style: const TextStyle(fontSize: 20),
          )
        : const Text("Null");
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 80,
                            child: ClipOval(
                              child: SizedBox(
                                width: 300,
                                height: 300,
                                child: CachedNetworkImage(
                                  imageUrl: widget.tutor.avatar,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(
                              widget.tutor.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ]),
                          Row(children: [
                            RatingBar.builder(
                              itemSize: 30,
                              initialRating: widget.tutor.getRating(),
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (double value) {},
                            )
                          ]),
                          Row(
                            children: [
                              Flag.fromString(
                                widget.tutor.country,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 10),
                              localNameView,
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                DateFormat('dd-MM-yyyy')
                    .format(DateTime.fromMillisecondsSinceEpoch(
                        widget.schedules.first.startPeriodTimestamp))
                    .toString(),
                style: titleStyle,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.schedules.length,
                  itemBuilder: (context, position) {
                    ScheduleDetailInfo schedule = widget.schedules[position];
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "From: " +
                                    DateFormat('HH:mm:ss')
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                schedule.startPeriodTimestamp))
                                        .toString(),
                                style: style,
                              ),
                              Text(
                                  "To: " +
                                      DateFormat('HH:mm:ss')
                                          .format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  schedule.endPeriodTimestamp))
                                          .toString(),
                                  style: style),
                              Checkbox(
                                value: chosenID == schedule.id,
                                fillColor: schedule.isBooked!
                                    ? MaterialStateProperty.all<Color>(
                                        Colors.grey)
                                    : MaterialStateProperty.all<Color>(
                                        Colors.lightBlue),
                                onChanged: (bool? newValue) {
                                  if (schedule.isBooked!) {
                                    null;
                                  } else {
                                    setState(() {
                                      if (newValue!) {
                                        chosenID = schedule.id;
                                      } else {
                                        chosenID = "";
                                      }
                                    });
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (chosenID == "") {
                      Utils.showSnackBar(
                          context, "No class was chosen", Colors.red);
                    } else {
                      _bookingViewModel
                          .bookAClass(chosenID, "")
                          .then((value) => {
                                Utils.showSnackBar(
                                    context,
                                    value.message,
                                    value.statusCode == 200
                                        ? Colors.green
                                        : Colors.red),
                                Navigator.pop(context, true)
                              });
                    }
                  },
                  child: Text(
                    "Book",
                    style: buttonTextStyle,
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )))),
            ],
          ),
        ),
      ),
    );
  }
}
