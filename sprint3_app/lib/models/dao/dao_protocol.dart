import 'package:sprint3_app/models/sqlite/app_database.dart';
import 'package:sprint3_app/models/sqlite/sqlite_protocol.dart';
import 'package:sqflite/sql.dart';

abstract class DaoProtocol<T extends SqliteProtocol<T>> {
  final AppDatabase dbProvider;
  final T model;

  DaoProtocol({
    required this.dbProvider, 
    required this.model,
  });

  Future<void> insert(T data) async {
    final db = await dbProvider.database; 

    await db.insert(
      model.table, 
      data.toSqliteMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  Future<List<T>> fetchAll() async {
    final db = await dbProvider.database;
    final maps = await db.query(model.table);
    return maps.map((element) => model.toSqliteModel(element)).toList();
  }

  Future<List<T>> fetchWhere({
    required String where,
    required List<Object?> whereArgs
  }) async {
    final db = await dbProvider.database;

    final maps = await db.query(
      model.table,
      where: where,
      whereArgs: whereArgs
    );

    return maps.map((element) => model.toSqliteModel(element)).toList();
  }

  Future<void> updateField({
    required String column,
    required Object? value,
    required String where,
  }) async {
    final db = await dbProvider.database;

    await db.update(
      model.table,
      {column: value},
      where: where,
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> clear() async {
    final db = await dbProvider.database;
    await db.delete(model.table);
  }
}