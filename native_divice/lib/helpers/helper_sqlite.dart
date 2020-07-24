import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class HelperSQLite {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, "Places.db"),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE UserPlaces (id TEXT PRIMARY KEY, title TEXT, image TEXT)");
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await HelperSQLite.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    //print("get data successed");
  }

  static Future<List<Map<String, dynamic>>> fetchGetData(String table) async {
    final db = await HelperSQLite.database();
    //await db.query(table).then((value) => print(value));
    return db.query(table);
  }
}
