import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:project/views/ScheduleViewPage.dart';
import 'package:project/widgets/HeroAnimation.dart';

import '../widgets/CustomAppBar.dart';
import 'CourseViewPage.dart';
import 'TutorViewPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _navScreens() {
    return [
      const TutorScreen(),
      const ScheduleScreen(),
      const Icon(
        Icons.chat,
        size: 150,
      ),
      const CourseScreen(),
      const Icon(
        Icons.chat,
        size: 150,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const FaIcon(FontAwesomeIcons.chalkboardTeacher),
        title: 'Tutor',
        activeColorPrimary: CupertinoColors.systemYellow,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.schedule),
        title: 'Schedule',
        activeColorPrimary: CupertinoColors.systemYellow,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.video_call),
        title: 'Conferance',
        activeColorPrimary: CupertinoColors.systemYellow,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.book_outlined),
        title: 'Courses',
        activeColorPrimary: CupertinoColors.systemYellow,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: 'Setting',
        activeColorPrimary: CupertinoColors.systemYellow,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final logo = IconHero(
      tag: 'logo',
      child: Image.asset('assets/images/logo.png',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 5),
    );
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(logo),
        body: Center(
          child: PersistentTabView(
            context,
            controller: _controller,
            screens: _navScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.black,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: const NavBarDecoration(
                colorBehindNavBar: Colors.indigo,),
            popAllScreensOnTapOfSelectedTab: true,
            navBarStyle: NavBarStyle.style6,
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
          ),
        ),
      ),
    );
  }
}
