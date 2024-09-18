part of "favourites_bloc.dart";

sealed class FavouritesState extends Equatable {
  const FavouritesState();
  @override
  List<Object?> get props => [];
}

final class FavouritesInitial extends FavouritesState {}

final class FavouritesInProgress extends FavouritesState {}

final class FavouritesSuccess extends FavouritesState {
  final List<Article> favourites;

  const FavouritesSuccess({required this.favourites});

  @override
  List<Object?> get props => [favourites];
}

final class FavouritesFailure extends FavouritesState {
  final String error;

  const FavouritesFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

// final class FavoritesCheckResult extends FavouritesState {
//   final bool isFavorite;

//   const FavoritesCheckResult(this.isFavorite);

//   @override
//   List<Object> get props => [isFavorite];
// }