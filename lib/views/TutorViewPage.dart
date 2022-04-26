import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/TutorModel.dart';
import '../resources/Specialties.dart';
import '../resources/Strings.dart';
import '../view_models/TutorViewModel.dart';
import 'TutorDetailsPage.dart';
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
  String skillSort = "all";

  @override
  Widget build(BuildContext context) {
    final tutorListOnProvider = Provider.of<TutorViewModel>(context);
    List<TutorInfo> tutorList = skillSort == "all"
        ? tutorListOnProvider.tutorList
        : tutorListOnProvider.filteredTutorList(skillSort);
    final tutorListView = tutorListOnProvider.tutorList.isNotEmpty
        ? ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tutorList.length,
            itemBuilder: (context, position) {
              final TutorInfo _tutor = tutorList[position];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TutorDetailsPage(
                              tutor: _tutor,
                            )));
                  },
                  child: TutorViewItem(
                    tutor: _tutor,
                  ),
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
                height: MediaQuery.of(context).size.height / 13,
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
                          itemCount: getAllSkillList().length,
                          itemBuilder: (context, position) {
                            return Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color:
                                    getAllSkillListKey()[position] == skillSort
                                        ? Colors.blue.shade100
                                        : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    skillSort = getAllSkillListKey()[position];
                                  });
                                },
                                child: Text(getAllSkillList()[position]),
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
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
