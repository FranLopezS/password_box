import 'package:flutter/material.dart';

import 'package:PasswordBox/src/pages/AddPage.dart';
import 'package:PasswordBox/src/pages/HomePage.dart';
import 'package:PasswordBox/src/pages/KeyPage.dart';
import 'package:PasswordBox/src/pages/PrehomePage.dart';
import 'package:PasswordBox/src/pages/SplashPage.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password Box',
      initialRoute: 'splash',
      routes: {
        'splash'  : (BuildContext context) => SplashPage(),
        'key'     : (BuildContext context) => KeyPage(),
        'prehome' : (BuildContext context) => PrehomePage(),
        'home'    : (BuildContext context) => HomePage(),
        'add'     : (BuildContext context) => AddPage()
      },
    );
  }
}
