import 'package:flutter/material.dart';

import 'package:PasswordBox/src/providers/db_provider.dart';
import 'package:PasswordBox/src/models/scan_model.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: getList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'add');
        },
      ),
    );
  }

  _showToast(String txt) {
    Toast.show(txt, context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
  }

  Widget getList() {
    return FutureBuilder(
      future: DBProvider.db.getTodoScans(),
      builder: (context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if(snapshot.hasData) {

          if(snapshot.data.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context2, i) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    child: Text('Borrar', textAlign: TextAlign.end, style: TextStyle(fontSize: 20.0)),
                    color: Colors.red
                  ),
                  onDismissed: (direccion) => DBProvider.db.deleteScan(snapshot.data[i].platform, snapshot.data[i].name),
                  child: ListTile(
                    title: Text("Cuenta de "+snapshot.data[i].platform + ": " + snapshot.data[i].name),
                    subtitle: Text('Pulsa aquí para ver la contraseña.'),
                    trailing: Icon(Icons.touch_app),
                    leading: Icon(Icons.account_balance_wallet),
                    onTap: () {
                      _showToast(snapshot.data[i].passwd);
                    },
                  ),
                );
              },
            );
          } else {
            return Text('No hay entradas.');
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
    
  }

}