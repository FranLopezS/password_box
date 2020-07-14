import 'package:flutter/material.dart';

import 'package:PasswordBox/src/providers/db_provider.dart';

import 'package:toast/toast.dart';

class PrehomePage extends StatefulWidget {

  @override
  _PrehomePageState createState() => _PrehomePageState();
}

class _PrehomePageState extends State<PrehomePage> {

  String _key = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: getBody(),
        ),
      ),
    );
  }

  _showToast(String txt) {
    Toast.show(txt, context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }

  Widget getBody() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20.0),
          Center(
            child: Text(
              'Introduce la clave de seguridad',
              style: TextStyle(
                fontSize: 20.0,
                backgroundColor: Colors.blue[100]
              ),
            ),
          ),
          SizedBox(height: 50.0),
          _inputKey(),
          SizedBox(height: 50.0),
          _submitButton()
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Center(
      child: FlatButton(
        onPressed: () {
          checkKey()
          .then((value) {
            if(value) Navigator.popAndPushNamed(context, 'home');
            else _showToast('Ckave incorrecta.');
          });
        },
        child: Icon(Icons.arrow_forward_ios),
        color: Colors.blue[200],
      ),
    );
  }

  Future<bool> checkKey() async {
    if(await DBProvider.db.checkKey(_key)) {
      return true;
    } else {
      return false;
    }
  }

  Widget _inputKey() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: '',
        labelText: 'Clave',
        //suffixIcon: Icon(Icons.assignment),
        icon: Icon(Icons.assignment)
      ),
      onChanged: (valor) {
        setState(() {
          _key = valor;
        });
      },
    );
  }
}