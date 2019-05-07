// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) {
  return Story(
      json['title'] as String,
      json['ga_prefix'] as String,
      (json['images'] as List)?.map((e) => e as String)?.toList(),
      json['multipic'] as bool,
      json['type'] as int,
      json['id'] as int);
}

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'title': instance.title,
      'ga_prefix': instance.ga_prefix,
      'images': instance.images,
      'multipic': instance.multipic,
      'type': instance.type,
      'id': instance.id
    };

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
      json['body'] as String,
      json['image_source'] as String,
      json['title'] as String,
      json['image'] as String,
      json['share_url'] as String,
      (json['js'] as List)?.map((e) => e as String)?.toList(),
      (json['css'] as List)?.map((e) => e as String)?.toList(),
      (json['recommenders'] as List)
          ?.map((e) => e == null
              ? null
              : Recommender.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['ga_prefix'] as String,
      json['section'] == null
          ? null
          : Section.fromJson(json['section'] as Map<String, dynamic>),
      json['type'] as int,
      json['id'] as int);
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'body': instance.body,
      'image_source': instance.image_source,
      'title': instance.title,
      'image': instance.image,
      'share_url': instance.share_url,
      'js': instance.js,
      'css': instance.css,
      'recommenders': instance.recommenders,
      'ga_prefix': instance.ga_prefix,
      'section': instance.section,
      'type': instance.type,
      'id': instance.id
    };

Recommender _$RecommenderFromJson(Map<String, dynamic> json) {
  return Recommender(json['avatar'] as String);
}

Map<String, dynamic> _$RecommenderToJson(Recommender instance) =>
    <String, dynamic>{'avatar': instance.avatar};

Section _$SectionFromJson(Map<String, dynamic> json) {
  return Section(
      json['id'] as int, json['thumbnail'] as String, json['name'] as String);
}

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'id': instance.id,
      'thumbnail': instance.thumbnail,
      'name': instance.name
    };
