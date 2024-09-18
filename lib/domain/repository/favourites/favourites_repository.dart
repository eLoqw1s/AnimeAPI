import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:android_dev/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouritesService extends FavouritesServiceInterface {
  FavouritesService({required this.dio});
  final Dio dio;

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');

  @override
  Future<void> addFavorite({
    required String id,
    required String title,
    required String image,
    required String link,
    required String synopsis,
  }) async {
    try {
      await favorites
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favourites')
          .doc(id)
          .set({
        '_id': id, // ТУТ ПОМЕНЯЛ
        'title': title,
        'image': image,
        'link': link,
        'timestamp': Timestamp.now(),
        'synopsis': synopsis,
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getFavorites() async {
    try {
      QuerySnapshot snapshot = await favorites
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favourites')
          .get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<void> deleteFavorite(String id) async {
    try {
      await favorites
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favourites')
          .doc(id)
          .delete();
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  // @override
  // Future<bool> isFavorite(String id) async {
  //   List<Map<String, dynamic>> favorites = await getFavorites();
  //   return favorites.any((favorite) => favorite['id'] == id);
  // }
}