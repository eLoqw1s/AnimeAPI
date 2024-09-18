part of "info_bloc.dart";

sealed class InfoState extends Equatable {
  const InfoState();
  @override
  List<Object> get props => [];
}

final class InfoInitial extends InfoState {}
final class InfoLoadInProgress extends InfoState {}
final class InfoLoadSuccess extends InfoState {
  const InfoLoadSuccess({
    required this.articles,
  });

  final Article articles;
  @override
  List<Object> get props => [articles];
}

final class InfoLoadFailure extends InfoState {
  const InfoLoadFailure({
    required this.exception,
  });
  final Object? exception;
  @override
  List<Object> get props => [];
}