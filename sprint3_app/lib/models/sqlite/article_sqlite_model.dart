import 'package:sprint3_app/models/sqlite/sqlite_protocol.dart';

class ArticleSqliteModel implements SqliteProtocol<ArticleSqliteModel> {
  final String id;
  final String? category;
  final String? sourceID;
  final String title;
  final String description;
  final String author;
  final String? url;
  final String? urlToImage;

  const ArticleSqliteModel({
    this.id = '',
    this.category,
    this.sourceID,
    this.title = '',
    this.description = '',
    this.author = '',
    this.url,
    this.urlToImage,
  });

  @override
  String get table => 'articles';

  @override
  String get createTableQuery =>
      '''
    CREATE TABLE $table (
      id TEXT PRIMARY KEY,
      category TEXT,
      sourceId TEXT,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      author TEXT NOT NULL,
      url TEXT,
      urlToImage TEXT
    );
  ''';

  @override
  Map<String, Object?> toSqliteMap() {
    return {
      'id': id,
      'category': category,
      'sourceId': sourceID,
      'title': title,
      'description': description,
      'author': author,
      'url': url,
      'urlToImage': urlToImage,
    };
  }

  @override
  ArticleSqliteModel toSqliteModel(Map<String, Object?> map) {
    return ArticleSqliteModel(
      id: map['id'] as String,
      category: map['category'] as String?,
      sourceID: map['sourceId'] as String?,
      title: map['title'] as String,
      description: map['description'] as String,
      author: map['author'] as String,
      url: map['url'] as String?,
      urlToImage: map['urlToImage'] as String?,
    );
  }
}
