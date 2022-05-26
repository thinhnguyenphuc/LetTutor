import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/ScheduleModel.dart';
import '../../models/TutorModel.dart';
import '../../resources/Strings.dart';
import 'ConferenceJitsiPage.dart';

class ConferenceViewItem extends StatefulWidget {
  final Schedule schedule;

  const ConferenceViewItem(
      {Key? key,
        required this.schedule})
      : super(key: key);

  @override
  _ConferenceViewItemState createState() => _ConferenceViewItemState();
}

class _ConferenceViewItemState extends State<ConferenceViewItem> {
  bool onClickRequest = true;

  @override
  Widget build(BuildContext context) {
    var time = widget.schedule.scheduleDetailInfo!.scheduleInfo!.date;
    TutorInfo? tutor =
        widget.schedule.scheduleDetailInfo!.scheduleInfo!.tutorInfo;
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: const Color.fromRGBO(237, 237, 240, 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(2, 4), // Shadow position
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Time
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(DateFormat.yMMMEd("en_US").format(time!),
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),

          //Tutor information
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Row(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 45,
                        child: ClipOval(
                          child: Image.network(
                            tutor!.avatar,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        tutor.name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ]),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.message),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              Strings.lessonDetails,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Column(
                children: [
                  Row(children: [
                    Text(
                        "Lesson Time: " +
                            widget.schedule.scheduleDetailInfo!.startPeriod +
                            " - " +
                            widget.schedule.scheduleDetailInfo!.endPeriod,
                        style: const TextStyle(fontSize: 25)),
                  ]),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Meeting(schedule: widget.schedule)));
                  },
                  style: OutlinedButton.styleFrom(
                    side:
                    const BorderSide(width: 1, color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.meeting_room),
                      Text("Go to meeting"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
