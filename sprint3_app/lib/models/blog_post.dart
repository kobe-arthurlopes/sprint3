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

  const BlogPostFields({this.title}) : super();

  static BlogPostFields fromJson(Map<String, dynamic> json) =>
      _$BlogPostFieldsFromJson(json);

  Map<String, dynamic> toJson() => _$BlogPostFieldsToJson(this);

  @override
  List<Object?> get props => [title];
}