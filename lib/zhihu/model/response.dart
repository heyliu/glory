import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'package:glory/zhihu/model/response.g.dart';


@JsonSerializable()
class Story {
  String title;
  String ga_prefix;
  List<String> images;
  bool multipic;
  int type;
  int id;

  Story(this.title, this.ga_prefix, this.images, this.multipic, this.type,
      this.id);

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);

  @override
  String toString() =>
      'Story{title: $title, ga_prefix: $ga_prefix, images: $images, multipic: $multipic, type: $type, id: $id}';
}

@JsonSerializable()
class Article {
  String body;
  String image_source;
  String title;
  String image;
  String share_url;
  List<String> js;
  List<String> css;
  List<Recommender> recommenders;
  String ga_prefix;
  Section section;
  int type;
  int id;

  Article(
      this.body,
      this.image_source,
      this.title,
      this.image,
      this.share_url,
      this.js,
      this.css,
      this.recommenders,
      this.ga_prefix,
      this.section,
      this.type,
      this.id);


  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class Recommender {
  String avatar;

  Recommender(this.avatar);

  factory Recommender.fromJson(Map<String, dynamic> json) =>
      _$RecommenderFromJson(json);

  Map<String, dynamic> toJson() => _$RecommenderToJson(this);
}

@JsonSerializable()
class Section {
  int id;
  String thumbnail;
  String name;

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionToJson(this);

  Section(this.id, this.thumbnail, this.name);
}
