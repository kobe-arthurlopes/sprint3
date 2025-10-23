class ArticleResponse {
  final List<Article> articles;

  ArticleResponse({required this.articles});

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    return ArticleResponse(
      articles: List.from(
        json['articles'],
      ).map((element) => Article.fromJson(element)).toList(),
    );
  }

  static ArticleResponse parseArticleResponse(Map<String, dynamic> json) {
    return ArticleResponse.fromJson(json);
  }
}

class Article {
  final String name;
  final String description;
  final String? url;

  Article({
    required this.name,
    required this.description,
    required this.url
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      name: json['source']['name'] ?? 'undefined', 
      description: json['description'] ?? 'undefined', 
      url: json['url']
    );
  }
}