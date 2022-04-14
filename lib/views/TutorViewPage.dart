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
            physics: const NeverScrollableScrollPhysics(),
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
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
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
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: const <Widget>[
                                        Text("Total lesson time is ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
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
                                                    BorderRadius.circular(28.0),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Column(
                      children: [
                        Text(Strings.findTutor,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            )),
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Flexible(
                                    child: Wrap(
                                      children: <Widget>[
                                        for (String skill in skillList)
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                2, 0, 2, 5),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  skillSort = skill;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 5),
                                                margin: const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: skill == skillSort
                                                      ? Colors.blue.shade100
                                                      : Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(skill),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
                tutorListView
              ],
            ),
          ),
        ),
    );
  }
}
