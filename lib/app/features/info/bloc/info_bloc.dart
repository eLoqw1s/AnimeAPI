import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:android_dev/di/di.dart';
import 'package:android_dev/domain/domain.dart';

part "info_event.dart";
part "info_state.dart";

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final AnimeByIdRepository animeByIdRepository;
  
  InfoBloc(this.animeByIdRepository) : super(InfoInitial()) {
    on<InfoLoad>(_infoLoad);
  }
  
  Future<void> _infoLoad(event, emit) async {
    try {
      if (state is! InfoLoadSuccess) {
        emit(InfoLoadInProgress());
      }
      final articles = await animeByIdRepository.getAnimeById();
      emit(InfoLoadSuccess(
        articles: articles,
      ));
    } 
    catch (exception, state) {
      emit(InfoLoadFailure(exception: exception));
      talker.handle(exception, state);
    } 
    finally {
      event.completer?.complete();
    }
  }
  
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}
