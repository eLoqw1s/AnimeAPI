import 'dart:async';
import 'package:dio/dio.dart';
import 'package:android_dev/data/data.dart';
import 'package:android_dev/domain/domain.dart';

class TopAnimeRepository extends TopAnimeRepositoryIterface {
  TopAnimeRepository({required this.dio});
  final Dio dio;
  @override
  Future<List<Article>> getTopAnime() async {
    try {
      final Response response = await dio.get(
        Endpoints.topAnime,
        queryParameters: {
          'page': '1',
          'size': '20',
        },
      );
      final anime = (response.data['data'] as List)
      .map((e) => Article.fromJson(e))
      .toList();
      return anime;
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }
}