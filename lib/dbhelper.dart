import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class dbhelper {
  static final databasename = "persons.db";
  static final databaseversion = 1;

  static final table = "my_table";
  static final columnid = "id";
  static final columnname = "names";
  static final columnage = "age";

  static Database? database;

  dbhelper.privateconstructor();
  static final dbhelper instance = dbhelper.privateconstructor();

  //function checking if database exists or not

  Future<Database?> get getdatabase async {
    // ignore: unnecessary_null_comparison
    if (database != null) {
      return database;
    } else {
      database = await initdatabase();
      return database;
    }
  }

//initializing/connecting the database with app directory
  initdatabase() async {
    Directory documentdir = await getApplicationDocumentsDirectory();
    String path = join(documentdir.path, databasename);
    return await openDatabase(
      path,
      version: databaseversion,
      onCreate: oncreate,
    );
  }

//actually creating  the database
  Future oncreate(Database db, int ver) async {
    await db.execute('''
       CREATE TABLE $table(
        $columnid INTEGER PRIMARY KEY,
        $columnname TEXT NOT NULL,
        $columnage INTEGER NOT NULL
       )
      ''');
  }

// functions for all queries
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.getdatabase;
    return await db!.insert(table, row);
  }

  //query all rows (output = list  of maps)
  Future<List<Map<String, dynamic>>> queryall() async {
    Database? db = await instance.getdatabase;
    return await db!.query(table);
  }

//query specific
  Future<List<Map<String, dynamic>>?> queryspecific(int age) async {
    Database? db = await instance.getdatabase;
    var result = await db?.query(table, where: "age<?", whereArgs: [age]);
    //raw query
    var res = await db?.rawQuery("SELECT * FROM my_table WHERE age<?", [age]);
    return res;
  }

//delete
  Future<int?> deletedata(int id) async {
    Database? db = await instance.getdatabase;
    var result = await db?.delete(table, where: "id=? ", whereArgs: [id]);
    return result;
  }

//update
  Future<int?> update(int id,String namee) async {
    Database? db = await instance.getdatabase;
    var result = db?.update(
        table,
        {
          "names": namee,
        },
        
        where: 'id=?',
        whereArgs: [id]);
    return result;
  }
}
