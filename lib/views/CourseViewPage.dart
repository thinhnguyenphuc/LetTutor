import 'package:flutter/material.dart';
import 'package:project/view_models/CourseViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/Course.dart';
import '../models/EBookModel.dart';
import '../resources/Strings.dart';
import '../view_models/EBookViewModel.dart';
import 'CourseDetailViewPage.dart';
import 'CourseViewItem.dart';
import 'EBookViewItem.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  _CourseScreenPageState createState() => _CourseScreenPageState();
}

class _CourseScreenPageState extends State<CourseScreen>
    with SingleTickerProviderStateMixin {
  final tabs = [
    Tab(text: Strings.courses),
    Tab(text: Strings.ebook),
  ];
  late TabController _tabController;
  int tabIndex = 0;
  bool isCourseDetails = false;
  late Course course;

  @override
  void initState() {
    super.initState();
    Provider.of<CourseViewModel>(context, listen: false).getCourseList();
    Provider.of<EBookViewModel>(context, listen: false).getEBookList();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  void onCourseTap(Course course) {
    isCourseDetails = true;
    this.course = course;
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isCourseDetails) {
      return Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: CourseDetailViewPage(
            course: course,
          ),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation.status == AnimationStatus.dismissed
                    ? Tween<double>(begin: .5, end: 1).animate(animation)
                    : const AlwaysStoppedAnimation(1.0),
                child: child,
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isCourseDetails = false;
            });
          },
          backgroundColor: Colors.blue.withOpacity(.5),
          child: const Icon(Icons.keyboard_backspace),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      );
    } else {
      final courseListOnProvider = Provider.of<CourseViewModel>(context);
      final eBookListOnProvider = Provider.of<EBookViewModel>(context);
      final courseList = courseListOnProvider.courseList;
      final eBookList = eBookListOnProvider.eBookList;
      if (courseList.isNotEmpty) {
        courseList.sort((a, b) =>
            a.categories.first.title.compareTo(b.categories.first.title));
      }
      final courseListView = courseList.isNotEmpty
          ? StickyGroupedListView<Course, String>(
              elements: courseList,
              groupBy: (Course course) => course.categories.first.title,
              groupSeparatorBuilder: (Course course) => SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.blue[300]!,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        course.categories.first.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Course course) => InkWell(
                child: CourseViewItem(course: course),
                onTap: () {
                  setState(() {
                    onCourseTap(course);
                  });
                },
              ),
              itemComparator: (element1, element2) => element1
                  .categories.first.title
                  .compareTo(element2.categories.first.title),
              // optional
              itemScrollController: GroupedItemScrollController(),
              // optional
              order: StickyGroupedListOrder.ASC, // optional
            )
          : const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            );

      final eBookListView = courseList.isNotEmpty
          ? ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: eBookList.length,
              itemBuilder: (context, position) {
                final EBook _ebook = eBookList[position];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                      onTap: () {
                        launchURL(_ebook.fileUrl);
                      },
                      child: EBookViewItem(
                        eBook: _ebook,
                      )),
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
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: DefaultTabController(
            length: 2,
            child: SwipeTo(
              child: Column(
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
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        onTap: (index) {
                          setState(() {
                            tabIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: tabIndex == 0 ? courseListView : eBookListView,
                  ),
                ],
              ),
              onLeftSwipe: () {
                if (++tabIndex > 1) tabIndex = 1;
                _tabController.animateTo(tabIndex);
                setState(() {
                  tabIndex;
                });
              },
              onRightSwipe: () {
                if (--tabIndex < 0) tabIndex = 0;
                _tabController.animateTo(tabIndex);
                setState(() {
                  tabIndex;
                });
              },
            ),
          ),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation.status == AnimationStatus.dismissed
                    ? Tween<double>(begin: 2.5, end: 1).animate(animation)
                    : const AlwaysStoppedAnimation(1.0),
                child: child,
              ),
            );
          },
        ),
      );
    }
  }
}