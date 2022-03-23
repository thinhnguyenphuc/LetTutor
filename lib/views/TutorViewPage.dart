import 'package:flutter/material.dart';

import '../models/tutorModel.dart';
import '../resources/Strings.dart';
import '../widgets/CustomInputField.dart';
import 'TutorViewItem.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({Key? key}) : super(key: key);

  @override
  _TutorScreenPageState createState() => _TutorScreenPageState();
}

class _TutorScreenPageState extends State<TutorScreen> {
  TextEditingController searchController = TextEditingController();

  final _tutor = Tutor(
      id: 1,
      name: 'Tokuda Shigeo',
      countryName: 'Japan',
      ratingStar: 4,
      skill: [],
      description: "Hello everyone! I'm Tokuda from Japan and I'm teaching English for about 5 years. In my courses, you'll be able to learn how to improve your English basic skills",
      imagePath: '');

  @override
  Widget build(BuildContext context) {
    final searchView = InputFieldButton(
      controller: searchController,
      inputAction: TextInputAction.search,
      height: MediaQuery.of(context).size.longestSide / 20,
      onSubmitted: (String value) {},
      onChanged: (String value) {},
      prefixIcon: const Icon(Icons.search),
      suffixIcon: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          searchController.clear();
        },
      ),
      hintText: Strings.search,
    );

    final tutorListView = ListView.builder(
      itemCount: 1,
      itemBuilder: (context, position) {
        return TutorViewItem(
          tutor: _tutor,
        );
      },
    );

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(Strings.tutor),
          backgroundColor: const Color(0xFF262626),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                tutorListView,
              ],
            ),
          ),
        ));
  }
}
