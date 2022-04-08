import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/Strings.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenPageState createState() => _ScheduleScreenPageState();
}

class _ScheduleScreenPageState extends State<ScheduleScreen> {

  @override
  Widget build(BuildContext context) {

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