import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/models/ScheduleModel.dart';
import 'package:project/view_models/ScheduleViewModel.dart';
import 'package:project/views/schedule_viewpages/ScheduleViewItem.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../resources/BaseMixinsWidget.dart';
import '../../resources/Strings.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenPageState createState() => _ScheduleScreenPageState();
}

class _ScheduleScreenPageState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin, StateVariablesMixin {
  final tabs = [
    Tab(text: Strings.upcomingLesson),
    Tab(text: Strings.lessonList),
    Tab(text: Strings.lessonHistory),
  ];

  late TabController _tabController;
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ScheduleViewModel>(context, listen: false).fetchSchedule();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  late DragStartDetails startVerticalDragDetails;
  late DragUpdateDetails updateVerticalDragDetails;
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final scheduleListOnProvider = Provider.of<ScheduleViewModel>(context);
    final totalLearnedTime = scheduleListOnProvider.isLoaded
        ? Text(
            l10n.totalLessonTime +
                scheduleListOnProvider.hour +
                l10n.hours +
                scheduleListOnProvider.min +
                l10n.minutes,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ))
        : const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
    List<Schedule> schedules = (tabIndex == 0
        ? scheduleListOnProvider.nextSchedule
        : tabIndex == 1
            ? scheduleListOnProvider.schedules
            : scheduleListOnProvider.historySchedule);
    final scheduleListView = scheduleListOnProvider.isLoaded
        ? ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: schedules.length,
            itemBuilder: (context, position) {
              final Schedule _schedule = schedules[position];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ScheduleViewItem(
                  viewModel: scheduleListOnProvider,
                  schedule: _schedule,
                  isDone: tabIndex != 0,
                ),
              );
            },
          )
        : const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          );
    return Scaffold(
      backgroundColor: Colors.white12,
      resizeToAvoidBottomInset: false,
      body: DefaultTabController(
        length: 3,
        child: SwipeTo(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 150.0),
                  child: Material(
                    color: Colors.black,
                    child: TabBar(
                      controller: _tabController,
                      tabs: tabs,
                      indicatorWeight: 4,
                      indicatorColor: Colors.greenAccent,
                      unselectedLabelStyle:
                          const TextStyle(fontStyle: FontStyle.normal),
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      onTap: (index) {
                        setState(() {
                          tabIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: tabIndex == 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(
                                5.0) //                 <--- border radius here
                            ),
                        color: Colors.blueGrey.shade500),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: <Widget>[totalLearnedTime],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 0, 16, 16),
                                      child: Column(
                                        children: <Widget>[
                                          Text(Strings.noUpcoming,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.date_range,
                                            color: Colors.blueGrey,
                                          ),
                                          Text(Strings.bookLesson,
                                              style: const TextStyle(
                                                  color: Colors.blueGrey))
                                        ],
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              return Colors.white54;
                                            }
                                            return Colors
                                                .white; // Use the component's default.
                                          }),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          28.0),
                                                  side: const BorderSide(
                                                      color: Colors.blue)))),
                                    )
                                  ],
                                ),
                              ]),
                            ])
                      ],
                    ),
                  ),
                ),
                Expanded(child: scheduleListView),
              ],
            ),
          ),
          onLeftSwipe: () {
            if (++tabIndex > 2) tabIndex = 2;
            _tabController.animateTo(tabIndex);
            setState(() {
              tabIndex;
            });
          },
          onRightSwipe: () {
            if (--tabIndex < 0) tabIndex = 0;
            _tabController.animateTo(tabIndex);
            setState(() {
              tabIndex;
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            scheduleListOnProvider.fetchScheduleAgain();
          });
        },
        child: const Icon(Icons.sync),
      ),
    );
  }
}
