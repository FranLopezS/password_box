import 'dart:io';

import 'package:PasswordBox/src/models/scan_model.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:password/password.dart';

class DBProvider {

  // Sólo podrá haber 1 instancia a la vez de esta clase.
  static Database _database;
  static final DBProvider db = DBProvider._(); // Inicializar con constructor privado.

  DBProvider._();

  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        // Lo que se crea cuando se crea la bbdd.
        await db.execute(
          'CREATE TABLE Passwords ('
          ' platform TEXT, '
          ' name TEXT, '
          ' passwd TEXT, '
          ' PRIMARY KEY (platform, name) '
          ')'
        );

        await db.execute(
          'CREATE TABLE Key ('
          ' key TEXT PRIMARY KEY '
          ')'
        );
      }
    );
  }

  // Crear registros en la bbdd.
  nuevoScanRaw(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.rawInsert(
      "INSERT into Passwords(platform, name, passwd) "+
      "VALUES ( '${nuevoScan.platform}', '${nuevoScan.name}', '${nuevoScan.passwd}' )"
    );
    return res;
  }

  nuevaKey(String key) async {
    String encodedKey = Password.hash('$key', new PBKDF2());
    final db = await database;
    final res = await db.rawInsert(
      "INSERT into Key(key) "+
      "VALUES ( '$encodedKey' )"
    );
    return res;
  }

  deleteKey() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Key');
    return res;
  }

  Future<bool> checkKey(String key) async {
    final db = await database;
    final res = await db.query('Key');
    Map<String, dynamic> data = res.first;
    String hash = data['key'];
    return Password.verify(key, hash);
  }

  Future<bool> checkIsKeyExists() async {
    final db = await database;
    final res = await db.query('Key');
    if(res.isNotEmpty) return true;
    else return false;
  }

  nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Passwords', nuevoScan.toJson());
    return res;
  }

  // SELECT - Obtener información.
  /*getScanPorPlataforma(String platform) async {
    final db = await database; // Para ver si podemos escribir en la bbdd.
    final res = await db.query('Scans', where: 'platform = ?', whereArgs: [platform]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null; // Si res no tá vacío... Devuelvo un json de ScanModel. 
  }*/

  Future<List<ScanModel>> getTodoScans() async {
    final db = await database;
    final res = await db.query('Passwords');

    List<ScanModel> list = res.isNotEmpty 
                              ? res.map((e) => ScanModel.fromJson(e))
                              .toList()
                              : [];
    return list;
  }

  Future<List<ScanModel>> getScansPorPlataforma(String platform) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Passwords WHERE platform='$platform'");

    List<ScanModel> list = res.isNotEmpty 
                              ? res.map((e) => ScanModel.fromJson(e))
                              .toList()
                              : [];
    return list;
  }
  
  // Actualizar.
  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Passwords', nuevoScan.toJson(),
                                  where: 'platform=?', whereArgs: [nuevoScan.platform]);
    return res;
  }

  // Eliminar registros.
  Future<int> deleteScan(String platform, String name) async {
    final db = await database;
    final res = await db.delete('Passwords', where: 'platform=? AND name=?', whereArgs: [platform, name]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Passwords');
    return res;
  }

}