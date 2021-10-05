import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rpl5/pages/home_page.dart';
import 'package:rpl5/pages/login_page.dart';
import 'package:rpl5/services/dialog_service.dart';
import 'package:rpl5/services/navigation_service.dart';
import 'ApiModel/router.dart';
import 'dialog_manager.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();
  runApp(MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scale India',
      home: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Scale India',
        builder: EasyLoading.init(
            builder: (context, child) => Navigator(
                  key: locator<DialogService>().dialogNavigationKey,
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    builder: (context) => DialogManager(child: child!),
                  ),
                )),
        navigatorKey: locator<NavigationService>().navigationKey,
        theme: new ThemeData(
          primaryColor: new Color(0xff09031D),
          fontFamily: 'Avenir',
          //unselectedWidgetColor: Colors.white
        ),
        home: LoginPage(),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
