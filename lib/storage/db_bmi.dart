import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String databaseName = 'BMi_database.sql';
String userTable = 'USER';

class DatabaseBMI {
  static final DatabaseBMI _instance = DatabaseBMI.inernel();
  late Database _database;

  factory DatabaseBMI() {
    return _instance;
  }

  Database get datebase => _database;

  DatabaseBMI.inernel();

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final String path = join(directory.path.toString(), databaseName);
    return _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE $userTable("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "name TEXT,"
            "gender TEXT,"
            "age INTEGER,"
            "height INTEGER,"
            "weight INTEGER,"
            "type TEXT,"
            "category TEXT,"
            "result INTEGER"
            ")");
      },
    );
  }
}
