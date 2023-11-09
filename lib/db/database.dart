import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Database {
  static const _dbName = 'bizcard.db';
  static const _dbVersion = 1;
  static const _tableName = 'contacts';
  static const _columnId = 'id';
  static const _columnName = 'name';
  static const _columnEmail = 'email';
  static const _columnPhone = 'phone';
  late sqflite.Database db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _dbName);
    db = (await sqflite.openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    ));
  }

  Future _onCreate(sqflite.Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        $_columnId INTEGER PRIMARY KEY,
        $_columnName TEXT NOT NULL,
        $_columnEmail TEXT NOT NULL,
        $_columnPhone TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    return await db.insert(
      _tableName,
      row,
      conflictAlgorithm: sqflite.ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await db.query(_tableName);
  }

  Future<List<Map<String, dynamic>>> query(int id) async {
    return await db.query(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Map<String, dynamic> row) async {
    int id = row[_columnId];
    return await db.update(
      _tableName,
      row,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    return await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
}