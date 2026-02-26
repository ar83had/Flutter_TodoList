import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper{

  //table name
  static const String TABLE_NOTES = "notes";
  static const String COLUMN_NOTES_SNO = "s_no";
  static const String COLUMN_NOTES_TITLE = "title";
  static const String COLUMN_NOTES_DESC = "description";

  //Singtal Object 
  
  DBHelper._();

  //Static member return single instance
  static final DBHelper getInstance = DBHelper._();

  //dbOpen (path is exist then open else create)

  Database? _myDB;

  Future<Database> _getDB() async{

    _myDB ??= await _openDB();

    return _myDB!;
  }

  Future<Database> _openDB() async{

    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "noteDB.db");
    debugPrint("Db Path is : $dbPath");

    return await openDatabase(dbPath,onCreate: (db,version){
      db.execute("create table $TABLE_NOTES ($COLUMN_NOTES_SNO integer primary key autoincrement, $COLUMN_NOTES_TITLE text, $COLUMN_NOTES_DESC text)");
    },version: 1);
  }


  //wait
  Future<bool> addNotes({required String title, required String desc}) async{
    _myDB = await _getDB();

    int rowAffected = await _myDB!.insert(TABLE_NOTES, {COLUMN_NOTES_TITLE:title,COLUMN_NOTES_DESC:title});

    return rowAffected>0;
  }

  Future<List<Map<String,dynamic>>>  getAllNotes() async{
    _myDB = await _getDB();

    List<Map<String,dynamic>> data = await _myDB!.query(TABLE_NOTES);

    return data;
  }


}