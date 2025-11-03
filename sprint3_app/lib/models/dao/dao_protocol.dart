import 'package:sprint3_app/models/sqlite/app_database.dart';
import 'package:sprint3_app/models/sqlite/sqlite_model.dart';
import 'package:sqflite/sql.dart';

abstract class DaoProtocol<T extends SqliteModel<T>> {
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

  Future<void> clear() async {
    final db = await dbProvider.database;
    await db.delete(model.table);
  }
}