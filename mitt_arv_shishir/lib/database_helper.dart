import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';  //Using Flutter's SQLite

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();         //defining the singleton class
    return _database!;
  }

  get db => null;

  static Future<Database> initDB() async {
    final databasesPath = await getDatabasesPath();     //determines path
    final path = join(databasesPath, 'my_database.db');  //joins our database to path

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {        //table creation
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            age INTEGER,                              
            gender TEXT,
            country TEXT,
            hobbies TEXT,
            children INTEGER
          )
        ''');

        await db.execute('''
        CREATE TABLE articles(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          content TEXT,
        )
      ''');

      },
    );
  }

  static Future<int> addUser(Map<String, dynamic> user) async {
    final db = await database;
    return db.insert('users', user);      //callable function that adds a user data
  }                                       // to table 'users'

  static Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await database;
    final results = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }
  static Future<int> deleteAllUsers() async {
    final db = await database;
    return db.delete('users');
  }
  static Future<int> addPost(Map<String, dynamic> article) async {
    var dbClient = await DBHelper().db;
    return await dbClient.insert('articles', article);
  }

}