import 'package:flutter/material.dart';
import 'package:hongdou_app/page/home/home.dart';
import 'package:hongdou_app/page/splash_screen.dart';

Map<String, Widget Function(BuildContext)> routesList = {
  // 启动页、登录、注册
  '/splash-screen': (context) => const SplashScreen(),
  '/home': (context) => const Home(),

  // "/opern-play": (context, {arguments}) => OpernPlay(arguments: arguments),
};
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function? pageContentBuilder = routesList[name];
  // 路由判断
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      return MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments),
      );
    } else {
      return MaterialPageRoute(
          builder: (context) => pageContentBuilder(context));
    }
  }
  return null;
};
