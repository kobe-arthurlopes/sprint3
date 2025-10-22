// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogPost _$BlogPostFromJson(Map<String, dynamic> json) => BlogPost(
  sys: SystemFields.fromJson(json['sys'] as Map<String, dynamic>),
  fields: BlogPostFields.fromJson(json['fields'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BlogPostToJson(BlogPost instance) => <String, dynamic>{
  'sys': instance.sys,
  'fields': instance.fields,
};

BlogPostFields _$BlogPostFieldsFromJson(Map<String, dynamic> json) =>
    BlogPostFields(
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$BlogPostFieldsToJson(BlogPostFields instance) =>
    <String, dynamic>{'title': instance.title, 'body': instance.body};
