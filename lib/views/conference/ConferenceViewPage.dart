import 'package:flutter/material.dart';
import 'package:project/models/ScheduleModel.dart';
import 'package:project/view_models/ScheduleViewModel.dart';
import 'package:project/views/schedule_viewpages/ScheduleViewItem.dart';
import 'package:provider/provider.dart';
import '../../resources/BaseMixinsWidget.dart';
import 'ConferenceViewItem.dart';

class ConferenceScreen extends StatefulWidget {
  const ConferenceScreen({Key? key}) : super(key: key);

  @override
  _ConferencePageState createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferenceScreen>
    with StateVariablesMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ScheduleViewModel>(context, listen: false).fetchSchedule();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final scheduleListOnProvider = Provider.of<ScheduleViewModel>(context);
    List<Schedule> schedules = scheduleListOnProvider.nextSchedule;
    final scheduleListView = scheduleListOnProvider.isLoaded
        ? ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: schedules.length,
      itemBuilder: (context, position) {
        final Schedule schedule = schedules[position];
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: ConferenceViewItem(
            schedule: schedule,
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Expanded(child: scheduleListView),
          ],
        ),
      ),
    );
  }
}
