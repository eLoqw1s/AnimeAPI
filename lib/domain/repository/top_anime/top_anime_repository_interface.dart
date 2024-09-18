import 'dart:async';
import 'package:android_dev/domain/domain.dart';
abstract class TopAnimeRepositoryIterface {
  Future<List<Article>> getTopAnime();
}