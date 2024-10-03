import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  /// Singleton/////
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();
  // static DBHelper? getInsance() {
  //   DBHelper._();
  // }

  ///// tables notes///////
  static const String TABLE_NOTE = 'notes';
  static const String COLUMN_NOTE_S_NO = 's_no';
  static const String COLUMN_NOTE_TITLE = 'title';
  static const String COLUMN_NOTE_DESC = 'desc';

  Database? myDB;

  //DB OPEN (PATH=> IF EXITS THEN OPEN ELSE CRETE DB)
  Future<Database?> getDB() async {
    if (myDB != null) {
      return myDB;
    } else {
      myDB = await openDB();
      return myDB;
    }
  }

  Future<Database?> openDB() async {
    Directory directoryPath = await getApplicationDocumentsDirectory();
    String dbpath = join(directoryPath.path, "noteDB.db");
    return await openDatabase(dbpath, version: 1, onCreate: (db, version) {
      db.execute(
          "CREATE TABLE $TABLE_NOTE($COLUMN_NOTE_S_NO INTEGER PRIMARY KEY AUTOINCREMENT, $COLUMN_NOTE_TITLE TEXT, $COLUMN_NOTE_DESC TEXT)");
    });
  }

  ////   ALL QUERIES
//INSERT DATA

  Future<bool?> addData({required String mtitle, required String mdesc}) async {
    var db = await getDB();
    int rowsEffected = await db!.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: mtitle,
      COLUMN_NOTE_DESC: mdesc,
    });
    return rowsEffected > 0; // true if data inserted
  }

// reding all data
  Future<List<Map<String, dynamic>>> getAllData() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db!.query(TABLE_NOTE);
    return mData;
  }

  ///update value///////////

  Future<bool> getUpdateNotes(
      {required String mtitle, required String mdesc, required int sno}) async {
    var db = await getDB();
    int roweffected = await db!.update(
      TABLE_NOTE,
      {COLUMN_NOTE_TITLE: mtitle, COLUMN_NOTE_DESC: mdesc},
      where: "$COLUMN_NOTE_S_NO=sno",
    );
    return roweffected > 0;
  }

  Future<bool?> getDeteledNotes({required int sno}) async {
    var db = await getDB();
    int rowseffected = await db!
        .delete(TABLE_NOTE, where: "$COLUMN_NOTE_S_NO=?", whereArgs: ['sno']);
    // int rowseffected = await db!.delete(
    // TABLE_NOTE,
    // where: "$COLUMN_NOTE_S_NO= sno",
    // );
    return rowseffected > 0;
  }
}
