import 'package:json_annotation/json_annotation.dart';
part 'article.g.dart';
@JsonSerializable()
class Article {
  Article({
    required this.id,
    required this.title,
    //required this.alternativeTitles,
    //required this.genres,
    required this.image,
    required this.link,
    //this.status,
    required this.synopsis,
    //required this.thumb,
    //required this.type
  });
  
  @JsonKey(name: '_id')
  final String id;
  final String title;
  //final List<String> alternativeTitles;
  //final List<String> genres;
  final String image;
  final String link;
  //final String? status;
  final String synopsis;
  //final String thumb;
  //final String type;

  factory Article.fromJson(Map<String, dynamic> json) =>
    _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}