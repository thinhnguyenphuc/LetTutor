import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Schedule.dart';
import '../models/TutorModel.dart';
import '../resources/CountryList.dart';
import '../resources/Strings.dart';

class ScheduleViewItem extends StatefulWidget {
  final Schedule schedule;

  const ScheduleViewItem({Key? key, required this.schedule}) : super(key: key);

  @override
  _ScheduleViewItemState createState() => _ScheduleViewItemState();
}

class _ScheduleViewItemState extends State<ScheduleViewItem> {
  bool onClickRequest = true;

  @override
  Widget build(BuildContext context) {
    var time = widget.schedule.scheduleDetailInfo.scheduleInfo.date;
    TutorInfo tutor = widget.schedule.scheduleDetailInfo.scheduleInfo.tutorInfo;
    var countryName = CountrySingleton().countryHashMap[tutor.country];
    final localNameView =
        countryName != null ? Text(countryName) : const Text("Null");
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(2, 4), // Shadow position
            ),
          ]),
      child: Column(
        children: [
          //Time
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Text(DateFormat.yMMMEd("en_US").format(time),
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
                            tutor.avatar,
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
                    Row(
                      children: [
                        Flag.fromString(
                          tutor.country,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 10),
                        localNameView,
                      ],
                    ),
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
          //LessonDetails
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
                            widget.schedule.scheduleDetailInfo.startPeriod +
                            " - " +
                            widget.schedule.scheduleDetailInfo.endPeriod,
                        style: const TextStyle(fontSize: 25)),
                  ]),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(onClickRequest
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_right),
                                onPressed: () {
                                  setState(() {
                                    onClickRequest = !onClickRequest;
                                  });
                                },
                              ),
                              Text("Request for lesson"),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Text("Edit Request"),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: onClickRequest,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10,10,10,10),
                              child: Text(widget.schedule.studentRequest != null
                                  ? widget.schedule.studentRequest!
                                  : Strings.emptyStudentRequests,
                                style: TextStyle(fontSize: 20, color: Colors.grey),),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.close_sharp,
                          color: Colors.red,
                        ),
                        Text("Cancel", style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.blue),
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
          ]),
        ],
      ),
    );
  }
}
