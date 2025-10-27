class ArticleResponse {
  final List<ArticleModel> articles;

  ArticleResponse({required this.articles});

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    return ArticleResponse(
      articles: List.from(
        json['articles'],
      ).map((element) => ArticleModel.fromJson(element)).toList(),
    );
  }

  static ArticleResponse parseArticleResponse(Map<String, dynamic> json) {
    return ArticleResponse.fromJson(json);
  }
}

class ArticleModel {
  final String title;
  final String description;
  final String author;
  final String? url;
  final String? urlToImage;

  ArticleModel({
    required this.title,
    required this.description,
    required this.author,
    required this.url,
    required this.urlToImage
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'No title', 
      description: json['description'] ?? 'No description',
      author: json['author'] ?? 'Unknown author', 
      url: json['url'],
      urlToImage: json['urlToImage']
    );
  }
}