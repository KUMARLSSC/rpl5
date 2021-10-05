import 'package:flutter/material.dart';
import 'package:rpl5/ApiModel/route_names.dart';
import 'package:rpl5/pages/home_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePageViewRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: HomePage(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child:
                        Text('There was a technical error ${settings.name}')),
              ));
  }
}

PageRoute _pageRoute({String? routeName, Widget? viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(name: routeName), builder: (_) => viewToShow!);
}
