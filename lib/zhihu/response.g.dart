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
