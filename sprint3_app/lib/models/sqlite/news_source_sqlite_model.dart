import 'package:sprint3_app/models/sqlite/sqlite_model.dart';

class NewsSourceSqliteModel implements SqliteModel<NewsSourceSqliteModel> {
  final String name;
  final String? logoUrl;
  final String? sourceId;
  final bool isActive;

  const NewsSourceSqliteModel({
    this.name = '',
    this.logoUrl,
    this.sourceId,
    this.isActive = false,
  });

  @override
  String get table => 'news_sources';
  
  @override
  String get createTableQuery => '''
    CREATE TABLE $table (
      name TEXT PRIMARY KEY,
      logoUrl TEXT,
      sourceId TEXT,
      isActive INTEGER NOT NULL
    );
  ''';
  
  @override
  Map<String, Object?> toSqliteMap() {
    return {
      'name': name,
      'logoUrl': logoUrl,
      'sourceId': sourceId,
      'isActive': isActive ? 1 : 0
    };
  }
  
  @override
  NewsSourceSqliteModel toSqliteModel(Map<String, Object?> map) {
    return NewsSourceSqliteModel(
      name: map['name'] as String,
      logoUrl: map['logoUrl'] as String?,
      sourceId: map['sourceId'] as String?,
      isActive: (map['isActive'] as int) == 1
    );
  }
}