import 'dart:io';
import 'package:covidapp/sqflitetutorial/sqflite_Model_Class.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHandler {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    // Two lines of code to create a database file
    Directory directory = await getApplicationDocumentsDirectory();
    String dbpath = join(directory.path, "mydatabaseFile.db");

    // This line is used for opening the file and creating the database
    _database =
        await openDatabase(dbpath, version: 1, onCreate: (db, version) async {
      await db.execute('''
         CREATE TABLE DatabaseTable(
          id INTEGER PRIMARY KEY ,
          name TEXT,
          age INTEGER
         )
        ''');
    });
    return _database;
  }

  // Insert data into the table
  // Future<void> insertData(int id, String name, int age) async {
  //   Database? db = await database;
  //   Map<String, Object?> map = {
  //     'id': id,
  //     'name': name,
  //     'age': age,
  //   };
  //   if (db != null) {
  //     await db.insert('DatabaseTable', map);
  //   } else {
  //     print('Error: Database is null.');
  //   }
  // }

  insertData(SqfliteModelClass sqflitemodelcalss) async {
    Database? db = await database;
    await db!.insert("DatabaseTable ", sqflitemodelcalss.tomap());
  }

  // Read data from the table
  // readData() async {
  //   Database? db = await database;

  //   if (db != null) {
  //     final List<Map<String, dynamic>> result = await db.query("DatabaseTable");
  //     return result;
  //   } else {
  //     print('Error: Database is null.');
  //     return [];
  //   }
  // }

  // Read data from the database and map to model class
  Future<List<SqfliteModelClass>> readData() async {
    Database? db = await database;

    final List<Map<String, dynamic>> result = await db!.query('DatabaseTable');
    return result.map((map) => SqfliteModelClass.fromMap(map)).toList();
  }

  deleteData(int id) async {
    Database? db = await database;
    db!.delete("DatabaseTable", where: 'id = ?', whereArgs: [id]);
  }

  updateData(SqfliteModelClass SqfliteModelClass) async {
    Database? db = await database;
    await db!.update("DatabaseTable ", SqfliteModelClass.tomap(),
        where: "id=?", whereArgs: [SqfliteModelClass.id]);
  }
}
