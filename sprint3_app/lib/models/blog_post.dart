import 'package:contentful/contentful.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog_post.g.dart';

@JsonSerializable()
class BlogPost extends Entry<BlogPostFields> {
  BlogPost({
    required SystemFields sys,
    required BlogPostFields fields,
  }) : super(sys: sys, fields: fields);

  static BlogPost fromJson(Map<String, dynamic> json) =>
      _$BlogPostFromJson(json);

  Map<String, dynamic> toJson() => _$BlogPostToJson(this);
}

@JsonSerializable()
class BlogPostFields extends Equatable {
  final String? title;
  final String? body;

  const BlogPostFields({this.title, this.body}) : super();

  static BlogPostFields fromJson(Map<String, dynamic> json) {
    return BlogPostFields(
      title: json['title'] as String?,
      body: _extractPlainText(json['body']),
    );
  }

  static String _extractPlainText(dynamic richText) {
    if (richText == null || richText['content'] == null) return '';

    final List<dynamic> content = richText['content'];
    return content
        .where((node) => node['nodeType'] == 'paragraph')
        .map((paragraph) {
          final texts = paragraph['content'] as List<dynamic>;
          return texts
              .map((t) => t['value'] ?? '')
              .join();
        })
        .join('\n');
  }

  Map<String, dynamic> toJson() => _$BlogPostFieldsToJson(this);

  @override
  List<Object?> get props => [title];
}