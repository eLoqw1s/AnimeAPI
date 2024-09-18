// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      id: json['_id'] as String,
      title: json['title'] as String,
      //alternativeTitles: (json['alternativeTitles'] as List<dynamic>)
      //    .map((e) => e as String)
      //    .toList(),
      //genres:
      //    (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      image: json['image'] as String,
      link: json['link'] as String,
      //status: json['status'] as String?,
      synopsis: json['synopsis'] as String,
      //thumb: json['thumb'] as String,
      //type: json['type'] as String,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      //'alternativeTitles': instance.alternativeTitles,
      //'genres': instance.genres,
      'image': instance.image,
      'link': instance.link,
      //'status': instance.status,
      'synopsis': instance.synopsis,
      //'thumb': instance.thumb,
      //'type': instance.type,
    };
