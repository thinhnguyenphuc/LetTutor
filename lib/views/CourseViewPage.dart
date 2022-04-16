import 'package:flutter/material.dart';
import 'package:project/view_models/CourseViewModel.dart';
import 'package:provider/provider.dart';
import '../resources/Strings.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  _CourseScreenPageState createState() => _CourseScreenPageState();
}

class _CourseScreenPageState extends State<CourseScreen> with SingleTickerProviderStateMixin  {

  final tabs = [
    Tab(text: Strings.courses),
    Tab(text: Strings.ebook),
  ];

  late TabController _tabController;

  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CourseViewModel>(context, listen: false).getCourseList();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
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
        ],
      ),
    );
  }

}