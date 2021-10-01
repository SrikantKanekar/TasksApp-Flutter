import 'dart:convert';

import 'package:auth/src/model/user.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class UserDatabase {
  static Future<Database> _database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath!, 'users.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_table (email TEXT PRIMARY KEY, username TEXT, password TEXT, favourites TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(User user) async {
    final db = await UserDatabase._database();
    db.insert(
      'user_table',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<User?> getUser(String email) async {
    final db = await UserDatabase._database();
    try {
      final json =
          await db.rawQuery('SELECT * FROM user_table WHERE email="$email"');
      return User.fromMap(json.first);
    } catch (e) {
      return null;
    }
  }

  static Future<void> deleteUser(String email) async {
    final db = await UserDatabase._database();
    await db.delete('user_table', where: 'email = ?', whereArgs: [email]);
  }

  static Future<bool> addFavourite(String email, String name) async {
    final db = await UserDatabase._database();
    var user = await UserDatabase.getUser(email);
    if (user != null && !user.favourites.contains(name)) {
      user.favourites.add(name);
      await db.rawUpdate('UPDATE user_table SET favourites = ? WHERE email = ?',
          [json.encode(user.favourites), email]);
      return true;
    }
    return false;
  }

  static Future<bool> removeFavourite(String email, String name) async {
    final db = await UserDatabase._database();
    var user = await UserDatabase.getUser(email);
    if (user != null && user.favourites.contains(name)) {
      user.favourites.remove(name);
      await db.rawUpdate('UPDATE user_table SET favourites = ? WHERE email = ?',
          [json.encode(user.favourites), email]);
      return true;
    }
    return false;
  }
}
