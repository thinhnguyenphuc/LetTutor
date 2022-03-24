import 'package:flutter/material.dart';
import '../models/tutorModel.dart';
import '../resources/DemoTutorList.dart';
import '../resources/Strings.dart';
import 'TutorViewItem.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({Key? key}) : super(key: key);

  @override
  _TutorScreenPageState createState() => _TutorScreenPageState();
}

class _TutorScreenPageState extends State<TutorScreen> {
  TextEditingController searchController = TextEditingController();
  final List<Tutor> tutorList = [tutor0,tutor1,tutor2,tutor3,tutor4,tutor5];

  @override
  Widget build(BuildContext context) {


    final searchView = IconButton(
      onPressed: () {
        showSearch(context: context, delegate: Search());
      },
      icon: const Icon(Icons.search),
    );

    final tutorListView = ListView.builder(
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(Strings.tutor),
          backgroundColor: const Color(0xFF262626),
          centerTitle: true,
          actions: [searchView],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              Flexible(fit: FlexFit.tight, child: tutorListView),
            ],
          ),
        ));
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            close(context, null);
          },
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
          }
        },
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: const TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = ['Tokuda', 'Bush', 'Tập Cận Bình', 'Kim Jongun'];

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
            },
          );
        });
  }
}
