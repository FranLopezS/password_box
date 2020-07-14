import 'package:flutter/material.dart';

import 'package:PasswordBox/src/providers/db_provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  String newPage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _createSplash(context),
      )
    );
  }

  Widget _createSplash(BuildContext context) {
    _quitSplash().then((value) {
      Navigator.popAndPushNamed(context, newPage);
    });

    return Container(
      child: Center(
        child: Text('PASSWORD BOX', style: TextStyle(color: Colors.orange[400]))
      )
    );
  }

  Future<bool> _quitSplash() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //bool firstTime = prefs.getBool('first_time');

    if (await DBProvider.db.checkIsKeyExists()) { // No es la primera vez.
      newPage = 'prehome';
    } else { // Primera vez.
      newPage = 'key';
    }
    print('New page: $newPage');

    return Future.delayed(Duration(milliseconds: 3000))
        .then((onValue) => true);
  }
}