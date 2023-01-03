import 'package:bmi_calculater/model/model_database.dart';
import 'package:bmi_calculater/storage/db_bmi.dart';
import 'package:sqflite/sqflite.dart';

class DbController{
  Database dataBase = DatabaseBMI().datebase;

  Future<int> create(DataBaseModel databaseBMI) async{
    int created = await dataBase.insert(userTable, databaseBMI.toMap());
    print(created);
    return created;
  }

  Future<bool> delete(int id)async{
    int deleted = await dataBase.delete(userTable , where: 'id=?' , whereArgs: [id]);
   return deleted == 1;
  }

  Future<List<DataBaseModel>> read() async {
    List<Map<String , dynamic>> data = await dataBase.query(userTable);
    return data.map((Map<String,dynamic> rowMap) => DataBaseModel.fromMap(rowMap)).toList();
  }

}