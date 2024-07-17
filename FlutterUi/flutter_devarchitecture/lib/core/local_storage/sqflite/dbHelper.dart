import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = await getDatabasesPath(); // get path to db
    String path = join(dbPath, "vital.db");
    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  FutureOr<void> _createDb(Database db, int version) {
    db.execute(
        //TODO: Add tables here
        "CREATE TABLE vital(id INTEGER PRIMARY KEY, name TEXT, value TEXT)");
  }

  Future<int> insert(Map<String, dynamic> row, String table) async {
    Database db = await this.db;
    var result = await db.insert(table, row);
    return result;
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    Database db = await this.db;
    var result = await db.query(table);
    return result;
  }

  Future<int> update(Map<String, dynamic> row, String table) async {
    Database db = await this.db;
    var result = await db.update(table, row);
    return result;
  }

  Future<int> delete(int id, String table) async {
    Database db = await this.db;
    var result = await db.rawDelete("DELETE FROM $table WHERE id = $id");
    return result;
  }

  Future<int> deleteAll(String table) async {
    Database db = await this.db;
    var result = await db.rawDelete("DELETE FROM $table");
    return result;
  }

  Future<int?> getCount(String table) async {
    Database db = await this.db;
    List<Map<String, dynamic>> x =
        await db.rawQuery("SELECT COUNT(*) FROM $table");
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecific(
      String table, String column, String value) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' ORDER BY id DESC");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificLimit(
      String table, String column, String value, int limit) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' ORDER BY id DESC LIMIT $limit");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificLimitOffset(
      String table, String column, String value, int limit, int offset) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' ORDER BY id DESC LIMIT $limit OFFSET $offset");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificLimitOffsetOrder(String table,
      String column, String value, int limit, int offset, String order) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' ORDER BY $order DESC LIMIT $limit OFFSET $offset");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificLimitOrder(String table,
      String column, String value, int limit, String order) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' ORDER BY $order DESC LIMIT $limit");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificOrder(
      String table, String column, String value, String order) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' ORDER BY $order DESC");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificOrderLimit(String table,
      String column, String value, String order, int limit) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' ORDER BY $order DESC LIMIT $limit");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificOrderLimitOffset(String table,
      String column, String value, String order, int limit, int offset) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' ORDER BY $order DESC LIMIT $limit OFFSET $offset");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificOrderOffset(String table,
      String column, String value, String order, int offset) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' ORDER BY $order DESC OFFSET $offset");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificOrderOffsetLimit(String table,
      String column, String value, String order, int offset, int limit) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' ORDER BY $order DESC OFFSET $offset LIMIT $limit");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificOrderOffsetLimitWhere(
      String table,
      String column,
      String value,
      String order,
      int offset,
      int limit,
      String where) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' AND $where ORDER BY $order DESC OFFSET $offset LIMIT $limit");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificOrderOffsetWhere(
      String table,
      String column,
      String value,
      String order,
      int offset,
      String where) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' AND $where ORDER BY $order DESC OFFSET $offset");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificOrderWhere(String table,
      String column, String value, String order, String where) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' AND $where ORDER BY $order DESC");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificWhere(
      String table, String column, String value, String where) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' AND $where ORDER BY id DESC");
    return result;
  }

  Future<List<Map<String, dynamic>>> querySpecificWhereLimit(String table,
      String column, String value, String where, int limit) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "SELECT * FROM $table WHERE $column = '$value' AND $where ORDER BY id DESC LIMIT $limit");
    return result;
  }
}
