import 'package:flutter/material.dart';
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
        ChangeNotifierProvider<TutorViewModel>(create: (context) => TutorViewModel()),
        ChangeNotifierProvider<ScheduleViewModel>(create: (context) => ScheduleViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
