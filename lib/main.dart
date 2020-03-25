import 'package:dualarim/provider/dark_mode_provider.dart';
import 'package:dualarim/theme/dark_mode_styles.dart';
import 'package:dualarim/util/check_time.dart';
import 'package:dualarim/util/routes.dart';
import 'package:dualarim/util/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
