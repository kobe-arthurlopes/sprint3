import 'package:sprint3_app/models/dto/dto_protocol.dart';
import 'package:sprint3_app/models/sqlite/article_sqlite_model.dart';

class ArticleResponse {
  final List<ArticleDTO> articles;

  ArticleResponse({required this.articles});

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    return ArticleResponse(
      articles: List.from(
        json['articles'],
      ).map((element) => ArticleDTO.fromJson(element)).toList(),
    );
  }

  static ArticleResponse parseArticleResponse(Map<String, dynamic> json) {
    return ArticleResponse.fromJson(json);
  }
}

class ArticleDTO implements DtoProtocol<ArticleSqliteModel> {
  final String? sourceId;
  final String title;
  final String description;
  final String author;
  final String? url;
  final String? urlToImage;

  const ArticleDTO({
    this.sourceId,
    this.title = 'Untitled',
    this.description = 'No description',
    this.author = 'No author',
    this.url,
    this.urlToImage
  });

  factory ArticleDTO.fromJson(Map<String, dynamic> json) {
    return ArticleDTO(
      sourceId: json['source']['id'],
      title: json['title'] ?? 'No title', 
      description: json['description'] ?? 'No description',
      author: json['author'] ?? 'Unknown author', 
      url: json['url'],
      urlToImage: json['urlToImage']
    );
  }

  factory ArticleDTO.fromSqlite(ArticleSqliteModel? sqliteModel) {
    if (sqliteModel == null) {
      return ArticleDTO();
    }

    return ArticleDTO(
      sourceId: sqliteModel.sourceID,
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
      sourceID: sourceId,
      title: title,
      description: description,
      author: author,
      url: url,
      urlToImage: urlToImage
    );
  }
}