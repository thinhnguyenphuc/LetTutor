import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:project/provider/locale_provider.dart';
import 'package:project/resources/SupportLocale.dart';
import 'package:project/view_models/CourseViewModel.dart';
import 'package:project/view_models/EBookViewModel.dart';
import 'package:project/view_models/ScheduleViewModel.dart';
import 'package:project/view_models/TutorViewModel.dart';
import 'package:project/view_models/UserViewModel.dart';
import 'package:project/view_models/WalletViewModel.dart';
import 'package:project/views/splash_viewpages/FirtsScreen.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
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
        ChangeNotifierProvider<WalletViewModel>(
            create: (context) => WalletViewModel()),
        ChangeNotifierProvider<UserViewModel>(
            create: (context) => UserViewModel()),
        ChangeNotifierProvider(
            create: (context) => LocaleProvider(),
            builder: (context, child) {
              return Consumer<LocaleProvider>(
                builder: (context,provider, child){
                  return MaterialApp(
                    localizationsDelegates: const [
                      LocaleNamesLocalizationsDelegate(),
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    locale: provider.locale ?? const Locale("en"),
                    supportedLocales: L10n.support,
                    home: AnimatedSplashScreen(
                        duration: 2000,
                        splash: Image.asset('assets/images/logo.png'),
                        splashIconSize: 500,
                        nextScreen: const FirstScreen(),
                        splashTransition: SplashTransition.fadeTransition,
                        backgroundColor: Colors.black54)
                  );
                },
              );
            }),
      ],
    );
  }
}
