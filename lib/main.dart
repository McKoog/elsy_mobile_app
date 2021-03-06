
import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import '/main_binding.dart';
import '/routes/navigation.dart';
import '/themes.dart';
import '/utils/translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
final navigatorKey = GlobalKey<NavigatorState>();
void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
  //runApp(MaterialApp(home: MyApp(),navigatorKey: navigatorKey,debugShowCheckedModeBanner: false,));
}

/*
  Старт нашего приложения
  Говорим, чтобы оверлейн телефона был прозрачный.
  Используем плагин Adaptive Theme, где будем работать с темами и используем фреймворк Getx, где прописываем локализацию, начальный маршрут и роуты и устанавливаем главные зависимости.
  Перенаправляемся в splashScreen.
*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    )); //top bar color
    return AdaptiveTheme(
      dark: mainDarkTheme,
      light: mainLightTheme,
      initial: AdaptiveThemeMode.dark,
      builder: (light, dark) => GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        translations: TextLocalization(),
        locale: Locale('ru', 'RU'),
        theme: light,
        darkTheme: dark,
        defaultTransition: Transition.zoom,
        initialRoute: Routes.splash,
        getPages: RoutePages.pages,
        initialBinding: MainBinding(),
      ),
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
