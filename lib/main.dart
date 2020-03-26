import 'package:catcher/catcher_plugin.dart';
import 'package:dualarim/provider/dark_mode_provider.dart';
import 'package:dualarim/theme/dark_mode_styles.dart';
import 'package:dualarim/util/routes.dart';
import 'package:dualarim/util/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  //debug configuration
  final CatcherOptions debugOptions =
      CatcherOptions(DialogReportMode(), [ConsoleHandler(), ToastHandler()]);

  //release configuration
  final CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
    EmailManualHandler(['satriantoro.bimo@yahoo.com']),
    ToastHandler()
  ]);

  //profile configuration
  final CatcherOptions profileOptions = CatcherOptions(
    DialogReportMode(),
    [ConsoleHandler(), ToastHandler()],
    handlerTimeout: 5000,
    customParameters: {'app_sname': 'dualirm'},
  );

  //MyApp is root widget
  Catcher(MyApp(),
      debugConfig: debugOptions,
      releaseConfig: releaseOptions,
      profileConfig: profileOptions);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkModeProvider themeChangeProvider = new DarkModeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkMode =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkModeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            navigatorKey: Catcher.navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkMode, context),
            title: 'dualirm',
            onGenerateRoute: Router.generateRoute,
            initialRoute: splashscreenRoute,
          );
        },
      ),
    );
  }
}
