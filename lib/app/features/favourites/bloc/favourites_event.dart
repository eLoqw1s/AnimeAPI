part of "favourites_bloc.dart";

sealed class FavouritesEvent extends Equatable {
  const FavouritesEvent();
  @override
  List<Object?> get props => [];
}

class FavouritesGet extends FavouritesEvent {}

class FavouritesAdd extends FavouritesEvent {
  final String id;
  final String title;
  final String image;
  final String link;
  final String synopsis;

  const FavouritesAdd({
    required this.id, 
    required this.title,
    required this.image,
    required this.link,
    required this.synopsis,
  });

  @override
  List<Object?> get props => [id, title, image, link];
}

class FavouritesDelete extends FavouritesEvent {
  final String id;
  const FavouritesDelete(this.id);

  @override
  List<Object?> get props => [id];
}

class CheckFavoriteEvent extends FavouritesEvent {
  final String id;

  const CheckFavoriteEvent(this.id);
}
