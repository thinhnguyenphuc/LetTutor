import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/views/ScheduleViewPage.dart';
import 'package:project/widgets/HeroAnimation.dart';

import '../widgets/CustomAppBar.dart';
import 'TutorViewPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    const List<Widget> _pages = <Widget>[
      TutorScreen(),
      ScheduleScreen(),
      Icon(
        Icons.chat,
        size: 150,
      ),
    ];

    final logo = IconHero(
      tag: 'logo',
      child: Image.asset('assets/images/logo.png',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 5),
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(logo),
        body: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.chalkboardTeacher),
              label: 'Tutor',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Schedule',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: 'Courses',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Setting',
              backgroundColor: Colors.black,
            ),
          ],
          currentIndex: _selectedIndex,
          //New
          onTap: _onItemTapped,
          selectedItemColor: Colors.amberAccent,
          unselectedIconTheme: const IconThemeData(
            color: Colors.grey,
          ),
          type: BottomNavigationBarType.shifting,
        ),
      ),
    );
  }
}
