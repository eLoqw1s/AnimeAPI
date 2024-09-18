import 'dart:async';
import 'package:dio/dio.dart';
import 'package:android_dev/data/data.dart';
import 'package:android_dev/domain/domain.dart';

class AnimeByIdRepository extends AnimeByIdRepositoryIterface {
  AnimeByIdRepository({required this.dio});
  final Dio dio;
  @override
  Future<Article> getAnimeById() async {
    try {
      final Response response = await dio.get(
        Endpoints.animeById
      );

      List<String> parts = Endpoints.animeById.split('/');
      String id = parts.last;
      Endpoints.animeById = Endpoints.animeById.replaceAll(id, 'ID');

      final anime = Article.fromJson(response.data);
      return anime;
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }
}