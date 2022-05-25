import 'package:flutter/material.dart';
import 'package:project/views/tutor_viewpages/TutorViewItem.dart';
import 'package:provider/provider.dart';

import '../../models/TutorModel.dart';
import '../../resources/CountryList.dart';
import '../../resources/Specialties.dart';
import '../../resources/Strings.dart';
import '../../view_models/TutorViewModel.dart';
import 'TutorDetailsPage.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({Key? key}) : super(key: key);

  @override
  _TutorScreenPageState createState() => _TutorScreenPageState();
}

class _TutorScreenPageState extends State<TutorScreen> {
  late final TextEditingController searchController;
  String tutorName = "";

  @override
  void initState() {
    searchController = TextEditingController()
      ..addListener(() {
        setState(() {
          tutorName = searchController.text;
        });
      });
    // TODO: implement initState
    super.initState();
    Provider.of<TutorViewModel>(context, listen: false).getTutorList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  String skillSort = "all";
  String country = "ALL";
  bool isFilter = false;

  @override
  Widget build(BuildContext context) {
    final dropDownSkillChoose = SizedBox(
      width: 150.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            isExpanded: true,
            value: skillSort,
            icon: const Icon(Icons.arrow_downward),
            style: const TextStyle(color: Colors.blue),
            onChanged: (String? newValue) {
              setState(() {
                skillSort = newValue!;
              });
            },
            items: getAllSkillListKey()
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          value.toUpperCase(),
                          textAlign: TextAlign.left,
                        )),
                      ],
                    )),
              );
            }).toList(),
          ),
        ),
      ),
    );

    final dropDownCountryChoose = SizedBox(
      width: 150.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            isExpanded: true,
            value: country,
            icon: const Icon(Icons.arrow_downward),
            style: const TextStyle(color: Colors.blue),
            onChanged: (String? newValue) {
              setState(() {
                country = newValue!;
              });
            },
            items: CountrySingleton()
                .countryHashMap
                .values
                .toList()
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          value,
                          textAlign: TextAlign.left,
                        )),
                      ],
                    )),
              );
            }).toList(),
          ),
        ),
      ),
    );

    final tutorListOnProvider = Provider.of<TutorViewModel>(context);
    List<TutorInfo> tutorList = (country == "ALL" &&
            skillSort == "all" &&
            tutorName == "")
        ? tutorListOnProvider.tutorList
        : tutorListOnProvider.filteredTutorList(tutorName, skillSort, country);

    final tutorListView = tutorListOnProvider.tutorList.isEmpty
        ? const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          )
        : tutorList.isEmpty
            ? const Center(
                child: Text("Empty"),
              )
            : ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tutorList.length,
                itemBuilder: (context, position) {
                  final TutorInfo tutor = tutorList[position];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TutorDetailsPage(
                                  tutor: tutor,
                                  tutorViewModel: tutorListOnProvider,
                                )));
                      },
                      child: TutorViewItem(
                        tutor: tutor,
                        tutorViewModel: tutorListOnProvider,
                      ),
                    ),
                  );
                },
              );

    final searchBar = TextField(
      controller: searchController,
      decoration: InputDecoration(
          labelText: Strings.tutorName,
          hintText: Strings.search,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              searchController.clear();
            },
            icon: const Icon(Icons.clear),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );

    return Scaffold(
      backgroundColor: Colors.white12,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: isFilter
                    ? MediaQuery.of(context).size.height / 9
                    : MediaQuery.of(context).size.height / 14,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: searchBar,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isFilter = !isFilter;
                              });
                            },
                            icon: const Icon(Icons.filter_list_alt),
                          )
                        ],
                      ),
                      Visibility(
                        visible: isFilter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            dropDownCountryChoose,
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  country = "ALL";
                                });
                              },
                              icon: const Icon(Icons.clear),
                            ),
                            dropDownSkillChoose,
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  skillSort = "all";
                                });
                              },
                              icon: const Icon(Icons.clear),
                            )
                          ],
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
