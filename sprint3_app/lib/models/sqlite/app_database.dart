import 'package:path/path.dart';
import 'package:sprint3_app/models/sqlite/article_sqlite_model.dart';
import 'package:sprint3_app/models/sqlite/banner_sqlite_model.dart';
import 'package:sprint3_app/models/sqlite/news_source_sqlite_model.dart';
import 'package:sprint3_app/models/sqlite/sqlite_protocol.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static const _databaseName = 'app_cache.db';
  static const _databaseVersion = 1;

  AppDatabase._privateConstructor();
  static final AppDatabase instance = AppDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    final List<SqliteProtocol<dynamic>> models = [
      const ArticleSqliteModel(),
      const NewsSourceSqliteModel(),
      const BannerSqliteModel()
    ];

    for (final model in models) {
      await db.execute(model.createTableQuery);
    }
  }
}