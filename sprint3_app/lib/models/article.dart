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
  final String title;
  final String description;
  final String? url;

  Article({
    required this.title,
    required this.description,
    required this.url
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'undefined', 
      description: json['description'] ?? 'undefined', 
      url: json['url']
    );
  }
}