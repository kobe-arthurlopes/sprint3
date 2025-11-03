import 'package:sprint3_app/models/sqlite/sqlite_model.dart';

class ArticleSqliteModel implements SqliteModel<ArticleSqliteModel> {
  final String title;
  final String description;
  final String author;
  final String? url;
  final String? urlToImage;

  const ArticleSqliteModel({
    this.title = '',
    this.description = '',
    this.author = '',
    this.url,
    this.urlToImage
  });

  @override
  String get table => 'articles';
  
  @override
  String get createTableQuery => '''
    CREATE TABLE $table (
      title TEXT PRIMARY KEY,
      description TEXT NOT NULL,
      author TEXT NOT NULL,
      url TEXT,
      urlToImage TEXT
    );
  ''';
  
  @override
  Map<String, Object?> toSqliteMap() {
    return {
      'title': title,
      'description': description,
      'author': author,
      'url': url,
      'urlToImage': urlToImage
    };
  }
  
  @override
  ArticleSqliteModel toSqliteModel(Map<String, Object?> map) {
    return ArticleSqliteModel(
      title: map['title'] as String,
      description: map['description'] as String, 
      author: map['author'] as String, 
      url: map['url'] as String?, 
      urlToImage: map['urlToImage'] as String?
    );
  }
}