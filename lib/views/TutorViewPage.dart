import 'package:flutter/material.dart';
import '../models/tutorModel.dart';
import '../resources/DemoTutorList.dart';
import '../resources/Strings.dart';
import '../widgets/CustomAppBar.dart';
import 'TutorViewItem.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({Key? key}) : super(key: key);

  @override
  _TutorScreenPageState createState() => _TutorScreenPageState();
}

class _TutorScreenPageState extends State<TutorScreen> {
  TextEditingController searchController = TextEditingController();
  final List<Tutor> tutorList = [
    tutor0,
    tutor1,
    tutor2,
    tutor3,
    tutor4,
    tutor5
  ];

  @override
  Widget build(BuildContext context) {
    final tutorListView = ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tutorList.length,
      itemBuilder: (context, position) {
        final Tutor _tutor = tutorList[position];
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: TutorViewItem(
            tutor: _tutor,
          ),
        );
      },
    );

    return Scaffold(
        backgroundColor: Colors.white12,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
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
                                          color: Colors.white,
                                        ),
                                        Text(Strings.bookLesson,
                                            style: const TextStyle(
                                                color: Colors.white))
                                      ],
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return Colors.black54;
                                          }
                                          return Colors
                                              .black12; // Use the component's default.
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
                tutorListView
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            child: const Icon(Icons.message_sharp),
            backgroundColor: Colors.blue,
            onPressed: () {}));
  }
}
