import 'package:cached_network_image/cached_network_image.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project/models/TutorModel.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/BookingInfoModel.dart';
import '../resources/CountryList.dart';
import '../view_models/TutorViewModel.dart';

class BookingPage extends StatefulWidget {
  final TutorViewModel tutorViewModel;
  final TutorInfo tutor;

  const BookingPage(
      {Key? key, required this.tutorViewModel, required this.tutor})
      : super(key: key);

  @override
  BookingPageState createState() => BookingPageState();
}

class BookingPageState extends State<BookingPage> {
  bool isLoaded = false;
  bool canBook = false;
  @override
  void initState() {
    super.initState();
    if (!isLoaded) {
      widget.tutorViewModel.fetchBookings(widget.tutor.userId).then((value) {
        setState(() {
          isLoaded = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var countryName = CountrySingleton().countryHashMap[widget.tutor.country];
    List<String> languages = widget.tutor.getLanguages(context);
    final localNameView = countryName != null
        ? Text(
      countryName,
      style: const TextStyle(fontSize: 20),
    )
        : const Text("Null");
    Map<String, List<BookingInfo>> schedulesMap =
        widget.tutorViewModel.schedulesMap;
    final calendarView = schedulesMap.containsKey(widget.tutor.userId)
        ? Container(
            padding: const EdgeInsets.all(5),
            child: SfCalendar(
              onTap: (CalendarTapDetails details) {
                setState(() {
                  if(details.date!.isAfter(DateTime.now())){
                    canBook = true;
                  } else {
                    canBook = false;
                  }
                });

              },
              view: CalendarView.month,
              dataSource: MeetingDataSource(schedulesMap[widget.tutor.userId]!),
              monthViewSettings: const MonthViewSettings(
                showAgenda: true,
                agendaViewHeight: 300,
              ),
              backgroundColor: Colors.white,
              cellBorderColor: Colors.black,
            ),
          )
        : Center(
            child: SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Text("Loading schedule..."),
                  ),
                  CircularProgressIndicator()
                ],
              ),
            ),
          );

    return Scaffold(
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
            Expanded(
              child: calendarView,
            ),
            OutlinedButton(onPressed: () {  },
              child: Text("Book a class this day", style: TextStyle(color: canBook ? Colors.green : Colors.grey),),
            )
          ],
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<BookingInfo> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.fromMillisecondsSinceEpoch(
        _getMeetingData(index).startTimestamp);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.fromMillisecondsSinceEpoch(
        _getMeetingData(index).endTimestamp);
  }

  BookingInfo _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final BookingInfo meetingData;
    if (meeting is BookingInfo) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
