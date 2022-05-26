import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Utils.dart';
import '../../models/ScheduleModel.dart';
import '../../models/TutorModel.dart';
import '../../resources/CountryList.dart';
import '../../resources/Strings.dart';
import '../../view_models/ScheduleViewModel.dart';
import '../conference/ConferenceJitsiPage.dart';

class ScheduleViewItem extends StatefulWidget {
  final Schedule schedule;
  final bool isDone;
  final ScheduleViewModel viewModel;

  const ScheduleViewItem(
      {Key? key,
      required this.schedule,
      required this.isDone,
      required this.viewModel})
      : super(key: key);

  @override
  _ScheduleViewItemState createState() => _ScheduleViewItemState();
}

class _ScheduleViewItemState extends State<ScheduleViewItem> {
  bool onClickRequest = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController requestedController = TextEditingController();
    var time = widget.schedule.scheduleDetailInfo!.scheduleInfo!.date;
    TutorInfo? tutor =
        widget.schedule.scheduleDetailInfo!.scheduleInfo!.tutorInfo;
    var countryName = CountrySingleton().countryHashMap[tutor?.country];
    final localNameView =
        countryName != null ? Text(countryName) : const Text("Null");
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

          Visibility(
            visible:
                widget.isDone && widget.schedule.studentMaterials!.isNotEmpty,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                Strings.learnedBooks,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),

          Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Visibility(
                visible: widget.isDone &&
                    widget.schedule.studentMaterials!.isNotEmpty,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.schedule.studentMaterials!.length,
                          itemBuilder: (context, position) {
                            return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                margin: const EdgeInsets.all(2),
                                child: TextButton(
                                  onPressed: () {
                                    if (widget
                                            .schedule
                                            .studentMaterials![position]
                                            .eBook !=
                                        null) {
                                      Utils.launchURL(widget
                                          .schedule
                                          .studentMaterials![position]
                                          .eBook!
                                          .fileUrl);
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      const Icon(Icons.book_sharp),
                                      Text(widget
                                          .schedule
                                          .studentMaterials![position]
                                          .eBook!
                                          .name)
                                    ],
                                  ),
                                ));
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                ),
              )),

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
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              Text(Strings.requestForLesson),
                              const Spacer(),
                              Visibility(
                                visible: !widget.isDone,
                                child: TextButton(
                                  onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Special Request'),
                                      content: TextField(
                                        controller: requestedController,
                                        decoration: const InputDecoration(
                                            hintText: "Request"),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            widget.viewModel
                                                .updateStudentRequest(
                                                    widget.schedule.id,
                                                    requestedController.text)
                                                .then((value) => {
                                                      if (value.statusCode ==
                                                          200)
                                                        {
                                                          setState(() {
                                                            widget.viewModel
                                                                .fetchScheduleAgain();
                                                          })
                                                        }
                                                    });
                                            Navigator.pop(context, 'Submit');
                                          },
                                          child: const Text('Submit'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: Text(Strings.editRequest),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: onClickRequest,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Text(
                                widget.schedule.studentRequest != null
                                    ? widget.schedule.studentRequest!
                                    : widget.isDone
                                        ? Strings.emptyStudentRequestsWhenDone
                                        : Strings.emptyStudentRequests,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),

          // Cancel and join meeting layout
          Visibility(
            visible: !widget.isDone,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                        child: OutlinedButton(
                          onPressed: () {
                            widget.viewModel
                                .cancelBookedClass(
                                    widget.schedule.scheduleDetailId)
                                .then((value) {
                              if (value.statusCode == 200) {
                                setState(() {
                                  Utils.showSnackBar(
                                      context, value.message, Colors.green);
                                  widget.viewModel.fetchScheduleAgain();
                                });
                              } else {
                                Utils.showSnackBar(
                                    context, value.message, Colors.green);
                              }
                            });
                          },
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
                              Text("Cancel",
                                  style: TextStyle(color: Colors.red)),
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
                ]),
          ),
        ],
      ),
    );
  }
}
