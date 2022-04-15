import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/TutorModel.dart';
import '../resources/DemoTutorList.dart';
import '../resources/Strings.dart';
import '../view_models/TutorViewModel.dart';
import 'TutorViewItem.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({Key? key}) : super(key: key);

  @override
  _TutorScreenPageState createState() => _TutorScreenPageState();
}

class _TutorScreenPageState extends State<TutorScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TutorViewModel>(context, listen: false).getTutorList();
  }

  TextEditingController searchController = TextEditingController();
  String skillSort = "";

  @override
  Widget build(BuildContext context) {
    final tutorListOnProvider = Provider.of<TutorViewModel>(context);
    final tutorListView = tutorListOnProvider.tutorList.isNotEmpty
        ? ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tutorListOnProvider.tutorList.length,
            itemBuilder: (context, position) {
              final TutorInfo _tutor = tutorListOnProvider.tutorList[position];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: TutorViewItem(
                  tutor: _tutor,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 14,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        spreadRadius: 8,
                        blurRadius: 6,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Text(Strings.findTutor,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            )),
                        Expanded(
                          child: ListView.builder(
                            itemCount: skillList.length,
                            itemBuilder: (context, position) {
                              return Container(
                                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: skillList[position] == skillSort
                                      ? Colors.blue.shade100
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      skillSort = skillList[position];
                                    });
                                  },
                                  child: Text(skillList[position]),
                                ),
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
            ),
            Expanded(
              child: tutorListView,
            ),
          ],
        ),
      ),
    );
  }
}
