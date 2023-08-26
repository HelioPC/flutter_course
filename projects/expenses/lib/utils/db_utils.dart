import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

sealed class DBUtils {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'transactions.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE transactions (id TEXT PRIMARY KEY, title TEXT, value REAL,'
          'milliseconds INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBUtils.database();

    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(
      String table, String id, Map<String, Object> data) async {
    final db = await DBUtils.database();

    await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> remove(String table, String id) async {
    final db = await DBUtils.database();

    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBUtils.database();

    return await db.query(table);
  }
}
