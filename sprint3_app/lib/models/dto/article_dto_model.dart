import 'package:sprint3_app/models/dto/dto_protocol.dart';
import 'package:sprint3_app/models/sqlite/article_sqlite_model.dart';

class ArticleResponse {
  final List<ArticleDTOModel> articles;

  ArticleResponse({required this.articles});

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    return ArticleResponse(
      articles: List.from(
        json['articles'],
      ).map((element) => ArticleDTOModel.fromJson(element)).toList(),
    );
  }

  static ArticleResponse parseArticleResponse(Map<String, dynamic> json) {
    return ArticleResponse.fromJson(json);
  }
}

class ArticleDTOModel implements DtoProtocol<ArticleSqliteModel> {
  final String title;
  final String description;
  final String author;
  final String? url;
  final String? urlToImage;

  const ArticleDTOModel({
    this.title = 'Untitled',
    this.description = 'No description',
    this.author = 'No author',
    this.url,
    this.urlToImage
  });

  factory ArticleDTOModel.fromJson(Map<String, dynamic> json) {
    return ArticleDTOModel(
      title: json['title'] ?? 'No title', 
      description: json['description'] ?? 'No description',
      author: json['author'] ?? 'Unknown author', 
      url: json['url'],
      urlToImage: json['urlToImage']
    );
  }

  factory ArticleDTOModel.fromSqlite(ArticleSqliteModel? sqliteModel) {
    if (sqliteModel == null) {
      return ArticleDTOModel();
    }

    return ArticleDTOModel(
      title: sqliteModel.title,
      description: sqliteModel.description,
      author: sqliteModel.author,
      url: sqliteModel.url,
      urlToImage: sqliteModel.urlToImage
    );
  }

  @override
  ArticleSqliteModel toSqlite() {
    return ArticleSqliteModel(
      title: title,
      description: description,
      author: author,
      url: url,
      urlToImage: urlToImage
    );
  }
}