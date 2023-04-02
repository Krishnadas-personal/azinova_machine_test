import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'items.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE items(itemName TEXT PRIMARY KEY,itemImage TEXT,itemDetails TEXT)');
    }, version: 1);
  }

  static Future<void> iteminsert(String table, Map<String, Object> data) async {
    final db = await DbHelper.database();
    db.insert(table, data,conflictAlgorithm: ConflictAlgorithm.ignore);
    
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbHelper.database();
    return db.query(table);
  }
}
