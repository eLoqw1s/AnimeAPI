part of "info_bloc.dart";

sealed class InfoEvent extends Equatable {
  const InfoEvent();
  @override
  List<Object> get props => [];
}

class InfoLoad extends InfoEvent {
  const InfoLoad({this.completer});
  final Completer? completer;
  @override
  List<Object> get props => [];
}