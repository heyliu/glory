import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'response.g.dart';

@JsonSerializable()
class Story {
  String title;
  List<Recommender> recommenders;
  @JsonKey(name: 'ga_prefix')
  String gaPrefix;
  List<String> images;
  bool multipic;
  int type;
  int id;

  Story(this.title, this.gaPrefix, this.images, this.multipic, this.type,
      this.id);

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);

  @override
  String toString() =>
      'Story{title: $title, ga_prefix: $gaPrefix, images: $images, multipic: $multipic, type: $type, id: $id}';
}


@JsonSerializable()
class BannerStory {
  String title;
  @JsonKey(name: 'ga_prefix')
  String gaPrefix;
  String image;
  bool multipic;
  int type;
  int id;

  BannerStory(this.title, this.gaPrefix, this.image, this.multipic, this.type,
      this.id);

  factory BannerStory.fromJson(Map<String, dynamic> json) => _$BannerStoryFromJson(json);

  Map<String, dynamic> toJson() => _$BannerStoryToJson(this);

  @override
  String toString() {
    return 'BannerStory{title: $title, gaPrefix: $gaPrefix, image: $image, multipic: $multipic, type: $type, id: $id}';
  }


}



@JsonSerializable()
class Article {
  String body;
  @JsonKey(name: 'image_source')
  String imageSource;
  String title;
  String image;
  @JsonKey(name: 'share_url')
  String shareUrl;
  List<String> js;
  List<String> css;
  List<Recommender> recommenders;
  @JsonKey(name: 'ga_prefix')
  String gaPrefix;
  Section section;
  int type;
  int id;

  Article(
      this.body,
      this.imageSource,
      this.title,
      this.image,
      this.shareUrl,
      this.js,
      this.css,
      this.recommenders,
      this.gaPrefix,
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



@JsonSerializable()
class StoriesIndex{
  String date;
  List<Story> stories;
  @JsonKey(name: "top_stories")
  List<BannerStory> topStories;


  StoriesIndex(this.date, this.stories, this.topStories);

  factory StoriesIndex.fromJson(Map<String, dynamic> json) =>
      _$StoriesIndexFromJson(json);

  Map<String, dynamic> toJson() => _$StoriesIndexToJson(this);

}
