import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class HostelDatabase {
  /// Singleton
  HostelDatabase._();

  static final HostelDatabase instance = HostelDatabase._();

  factory HostelDatabase() {
    return instance;
  }

  /// Table and column names
  static const String TABLE_NOTE = 'hostel';
  static const String COLUMN_NOTE_S_NO = 's_no';
  static const String COLUMN_NOTE_TITLE = 'title';
  static const String COLUMN_NOTE_DESC = 'desc';

  Database? myDB;

  /// Open or create the database
  Future<Database?> getDB() async {
    if (myDB != null) {
      return myDB;
    } else {
      myDB = await _openDB();
      return myDB;
    }
  }

  Future<Database?> _openDB() async {
    Directory directoryPath = await getApplicationDocumentsDirectory();
    String dbPath = join(directoryPath.path, "hostel.db");
    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $TABLE_NOTE($COLUMN_NOTE_S_NO INTEGER PRIMARY KEY AUTOINCREMENT, $COLUMN_NOTE_TITLE TEXT, $COLUMN_NOTE_DESC TEXT)");
    });
  }

  /// Insert data
  Future<bool?> addData({required String mtitle, required String mdesc}) async {
    var db = await getDB();
    int rowsAffected = await db!.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: mtitle,
      COLUMN_NOTE_DESC: mdesc,
    });
    return rowsAffected > 0; // true if data inserted
  }

  /// Read all data
  Future<List<Map<String, dynamic>>> getAllData() async {
    var db = await getDB();
    return await db!.query(TABLE_NOTE);
  }

  /// Update a note
  Future<bool?> updateNotes(
      {required String mtitle, required String mdesc, required int sno}) async {
    var db = await getDB();
    int rowsAffected = await db!.update(
      TABLE_NOTE,
      {COLUMN_NOTE_TITLE: mtitle, COLUMN_NOTE_DESC: mdesc},
      where: "$COLUMN_NOTE_S_NO = ?",
      whereArgs: [sno],
    );
    return rowsAffected > 0;
  }

  /// Delete a note
  Future<bool?> deleteNotes({required int sno}) async {
    var db = await getDB();
    int rowsAffected = await db!.delete(
      TABLE_NOTE,
      where: "$COLUMN_NOTE_S_NO = ?",
      whereArgs: [sno],
    );
    return rowsAffected > 0;
  }
}
