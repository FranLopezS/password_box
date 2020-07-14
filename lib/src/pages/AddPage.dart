import 'package:flutter/material.dart';
import 'package:PasswordBox/src/models/scan_model.dart';
import 'package:PasswordBox/src/providers/db_provider.dart';

class AddPage extends StatefulWidget {

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  
  String _platform, _name, _passwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: getColumn(),
        )
      )
    );
  }

  Widget getColumn() {
    return Column(
      children: [
        SizedBox(height: 20.0),
        Center(
          child: Text(
            'Inserta una entrada',
            style: TextStyle(
              fontSize: 30.0,
              backgroundColor: Colors.blue[300]
            ),
          ),
        ),
        SizedBox(height: 50.0),
        _inputPlatform(),
        SizedBox(height: 50.0),
        _inputName(),
        SizedBox(height: 50.0),
        _inputPasswd(),
        SizedBox(height: 50.0),
        _submitButton()
      ],
    );
  }

  Widget _inputPlatform() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'EJ: Twitter, Nintendo...',
        labelText: 'Aplicación',
        //suffixIcon: Icon(Icons.assignment),
        icon: Icon(Icons.assignment)
      ),
      onChanged: (valor) {
        setState(() {
          _platform = valor;
        });
      },
    );
  }

  Widget _inputName() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'EJ: @Alfonsita, @Lolo',
        labelText: 'Nombre de usuario',
        //suffixIcon: Icon(Icons.assignment),
        icon: Icon(Icons.assignment_ind)
      ),
      onChanged: (valor) {
        setState(() {
          _name = valor;
        });
      },
    );
  }

  Widget _inputPasswd() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: '',
        labelText: 'Contraseña',
        //suffixIcon: Icon(Icons.assignment),
        icon: Icon(Icons.assignment_late),

      ),
      onChanged: (valor) {
        setState(() {
          _passwd = valor;
        });
      },
    );
  }
  
  Widget _submitButton() {
    return Center(
      child: FlatButton(
        onPressed: () {
          if(_platform.isNotEmpty && _name.isNotEmpty && _passwd.isNotEmpty) {
            DBProvider.db.nuevoScanRaw(ScanModel(platform: _platform, name: _name, passwd: _passwd));
            Navigator.popAndPushNamed(context, 'home');
          }
        },
        child: Icon(Icons.add),
        color: Colors.blue[200],
      ),
    );
  }

}