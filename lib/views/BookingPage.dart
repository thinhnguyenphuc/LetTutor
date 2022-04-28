import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/BookingInfoModel.dart';
import '../models/ScheduleModel.dart';
import '../view_models/TutorViewModel.dart';

class BookingPage extends StatefulWidget {
  final TutorViewModel tutorViewModel;
  final String userId;

  const BookingPage(
      {Key? key, required this.tutorViewModel, required this.userId})
      : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!isLoaded) {
      widget.tutorViewModel.fetchBookings(widget.userId).then((value) {
        setState(() {
          isLoaded = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<BookingInfo>> schedulesMap =
        widget.tutorViewModel.schedulesMap;
    final calendarView = schedulesMap.containsKey(widget.userId)
        ? Container(
            padding: const EdgeInsets.all(5),
            child: SfCalendar(
              view: CalendarView.month,
              dataSource: MeetingDataSource(schedulesMap[widget.userId]!),
              monthViewSettings: const MonthViewSettings(
                showAgenda: true,
                agendaViewHeight: 400,
              ),
              backgroundColor: Colors.white,
              cellBorderColor: Colors.black,
            ),
          )
        : const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
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
            Expanded(
              child: calendarView,
            ),
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
    return DateTime.fromMicrosecondsSinceEpoch(
        _getMeetingData(index).endTimestamp*1000);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.fromMicrosecondsSinceEpoch(
        _getMeetingData(index).startTimestamp*1000);
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
