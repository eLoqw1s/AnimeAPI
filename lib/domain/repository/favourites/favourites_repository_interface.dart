import 'dart:async';

abstract class FavouritesServiceInterface {
  Future<void> addFavorite({required String id,
    required String title,
    required String image,
    required String link,
    required String synopsis,
  });

  Future<List<Map<String, dynamic>>> getFavorites();

  Future<void> deleteFavorite(String id);

  //Future<bool> isFavorite(String id);
}