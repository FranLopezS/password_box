import 'package:flutter/material.dart';

import 'package:toast/toast.dart';
import 'package:PasswordBox/src/providers/db_provider.dart';

class KeyPage extends StatefulWidget {

  @override
  _KeyPageState createState() => _KeyPageState();
}

class _KeyPageState extends State<KeyPage> {

  String _key, _key2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: getBody(),
        ),
      )
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
              'Escoge una clave segura, que no hayas usado en otro lugar, con un mínimo de 8 caracteres, '+
              'y con al menos una minúscula, una mayúcula y un número.',
              style: TextStyle(
                fontSize: 20.0,
                backgroundColor: Colors.blue[300]
              ),
            ),
          ),
          SizedBox(height: 50.0),
          _inputKey(),
          SizedBox(height: 50.0),
          _inputKey2(),
          SizedBox(height: 25.0),
          _submitButton()
        ],
      ),
    );
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

  Widget _inputKey2() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: '',
        labelText: 'Confirmación',
        //suffixIcon: Icon(Icons.assignment),
        icon: Icon(Icons.assignment)
      ),
      onChanged: (valor) {
        setState(() {
          _key2 = valor;
        });
      },
    );
  }

  Widget _submitButton() {
    return Center(
      child: FlatButton(
        onPressed: () {
          bool validKey = checkKey();
          if(validKey) {
            DBProvider.db.nuevaKey(_key);
            Navigator.popAndPushNamed(context, 'home');
          }
        },
        child: Icon(Icons.arrow_forward_ios),
        color: Colors.blue[200],
      ),
    );
  }

  bool checkKey() {
    if(_key.isEmpty || _key.length < 8) {
      _showToast('La clave debe tener una longitud mínima de 8 caracteres.');
      return false;
    }

    bool upper = false, inner = false, number = false;
    for(int i=0; i<_key.length; i++) {
      if(isNumber(_key[i])) number = true;
      if(isUpper(_key[i])) upper = true;
      else if(!isUpper(_key[i])) inner = true;
    }
    if(!upper || !inner || !number) {
      _showToast('La clave debe tener minúsculas, mayúsculas y números.');
      return false;
    }

    if(_key != _key2) {
      _showToast('Las claves no coinciden.');
      return false;
    }

    return true;

  }

  bool isUpper(String c) {
    if (c.toUpperCase() == c) {
      return true;
    } else {
      return false;
    }
  }

  bool isNumber(String c) {
    try {
      int.parse(c);
      return true;
    } catch(e) {
      return false;
    }
  }

}