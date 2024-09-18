import 'package:android_dev/di/di.dart';
import 'package:equatable/equatable.dart';
import 'package:android_dev/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "favourites_event.dart";
part "favourites_state.dart";

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final FavouritesService favouritesService;

  FavouritesBloc(this.favouritesService) : super(FavouritesInitial())  {
    on<FavouritesGet>(_favouritesGet);
    on<FavouritesAdd>(_favouritesAdd);
    on<FavouritesDelete>(_favouritesDelete);
    //on<CheckFavoriteEvent>(_checkFavoriteEvent);
  }

  Future<void> _favouritesGet(
      FavouritesGet event, Emitter<FavouritesState> emit) async {
    emit(FavouritesInProgress());
    try {
      //await favouritesService.getFavorites();
      //emit(FavouritesSuccess());
      final List<Map<String, dynamic>> favouritesMaps = await favouritesService.getFavorites();
      

      final List<Map<String, dynamic>> favouritesWithoutTimestamp = favouritesMaps.map((favourite) {
        final favWithoutTimestamp = Map<String, dynamic>.from(favourite);
        favWithoutTimestamp.remove('timestamp');
        return favWithoutTimestamp;
      }).toList();
      
      final List<Article> favourites = favouritesWithoutTimestamp
        .map((favourite) => Article.fromJson(favourite))
        .toList();

        

        emit(FavouritesSuccess(favourites: favourites));
    } catch (e) {
      emit(FavouritesFailure(error: e.toString()));
    }
  }

  Future<void> _favouritesAdd(
      FavouritesAdd event, Emitter<FavouritesState> emit) async {
    emit(FavouritesInProgress());
    try {
      await favouritesService.addFavorite(
        id: event.id,
        title: event.title,
        image: event.image,
        link: event.link,
        synopsis: event.synopsis,
      );
      //emit(FavouritesSuccess());
      // final List<Article> favourites = (await favouritesService.getFavorites())
      //   .map((favourite) => Article.fromJson(favourite))
      //   .toList();
        final List<Article> favourites = [];
        emit(FavouritesSuccess(favourites: favourites));
    } catch (e) {
      emit(FavouritesFailure(error: e.toString()));
    }
  }

  Future<void> _favouritesDelete(
      FavouritesDelete event, Emitter<FavouritesState> emit) async {
    emit(FavouritesInProgress());
    try {
      await favouritesService.deleteFavorite(event.id);
      //emit(FavouritesSuccess());
      // final List<Article> favourites = (await favouritesService.getFavorites())
      //   .map((favourite) => Article.fromJson(favourite))
      //   .toList();
      final List<Map<String, dynamic>> favouritesMaps = await favouritesService.getFavorites();
      

      final List<Map<String, dynamic>> favouritesWithoutTimestamp = favouritesMaps.map((favourite) {
        final favWithoutTimestamp = Map<String, dynamic>.from(favourite);
        favWithoutTimestamp.remove('timestamp');
        return favWithoutTimestamp;
      }).toList();
      
      final List<Article> favourites = favouritesWithoutTimestamp
        .map((favourite) => Article.fromJson(favourite))
        .toList();
        emit(FavouritesSuccess(favourites: favourites));
    } catch (e) {
      emit(FavouritesFailure(error: e.toString()));
    }
  }

  // Future<void> _checkFavoriteEvent(
  //     CheckFavoriteEvent event, Emitter<FavouritesState> emit) async {
  //   emit(FavouritesInProgress());
  //   try {
  //     final isFavorite = await favouritesService.isFavorite(event.id);
  //     emit(FavoritesCheckResult(isFavorite));
  //   } catch (e) {
  //     emit(FavouritesFailure(error: e.toString()));
  //   }
  // }
  
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}