import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_thailand_provinces/flutter_thailand_provinces.dart';
import 'package:nuxyoung/Pages/welcome_page.dart';
import 'package:nuxyoung/Auth/login_page.dart';
import 'package:nuxyoung/Tebbar/home_bottombar.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThailandProvincesDatabase.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan[900],
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('th', 'TH'),
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/login': (BuildContext context) => Loginpage()
      },
      title: 'Nux Young',
      home: Welcome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
