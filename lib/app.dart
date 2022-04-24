import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:project/view_models/CourseViewModel.dart';
import 'package:project/view_models/EBookViewModel.dart';
import 'package:project/view_models/ScheduleViewModel.dart';
import 'package:project/view_models/TutorViewModel.dart';
import 'package:project/views/Splash.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TutorViewModel>(
            create: (context) => TutorViewModel()),
        ChangeNotifierProvider<ScheduleViewModel>(
            create: (context) => ScheduleViewModel()),
        ChangeNotifierProvider<CourseViewModel>(
            create: (context) => CourseViewModel()),
        ChangeNotifierProvider<EBookViewModel>(
            create: (context) => EBookViewModel()),
      ],
      child: const MaterialApp(
        localizationsDelegates: [
          LocaleNamesLocalizationsDelegate(),
        ],
        home: SplashScreen(),
      ),
    );
  }
}
