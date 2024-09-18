import 'dart:async';
import 'package:android_dev/domain/domain.dart';
abstract class AnimeByIdRepositoryIterface {
  Future<Article> getAnimeById();
}