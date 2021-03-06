import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modak/dto/SavedUser.dart';
import 'package:modak/dto/ModakUser.dart';
import 'package:modak/main.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBRepository().saveUser(SavedUser(email: "test@test.com", password: "test123"));
  print(await DBRepository().loadUser());

  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Text("test"),
      ),
    ),
  ));
}

class DBRepository {
  Future saveUser(SavedUser user) async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'modak.db'),
      onCreate: (db, version) {
        print('version: $version');
        return db.execute(
            'create table if not exists user (email text primary key, password text)');
      },
      version: 1,
    );
    
    await database.execute('drop table if exists user');
    await database.execute('create table if not exists user (email text primary key, password text)');

    await database.insert('user', user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    print("saved");

  }

  Future<SavedUser?> loadUser() async {
    print("load..");
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'modak.db'),
      onCreate: (db, version) {
        print('version: $version');
        return db.execute(
            'create table if not exists user (email text primary key, password text)');
      },
      version: 1,
    );

    var users = await database.query('user');

    if (users.length <= 0 || users[0]['email'] == null || users[0]['password'] == null) {
      return null;
    }

    return SavedUser(email: users[0]['email'].toString(), password: users[0]['password'].toString());
  }

  Future deleteUser() async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'modak.db'),
      version: 1,
    );

    var res = await database.delete('user');
    print("res: $res");
  }

}
