import 'package:android_dev/data/dio/set_up.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../app/features/features.dart';
import '../domain/domain.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();
final Dio dio = Dio();

Future<void> setupLocator() async {
  setUpDio();

  getIt.registerSingleton<Dio>(dio);
  //getIt.registerSingleton<Talker>(talker);

  getIt.registerSingleton(TopAnimeRepository(dio:getIt<Dio>()));
  getIt.registerSingleton(HomeBloc(getIt.get<TopAnimeRepository>()));

  getIt.registerSingleton(AnimeByIdRepository(dio:getIt<Dio>()));
  getIt.registerSingleton(InfoBloc(getIt.get<AnimeByIdRepository>()));

  getIt.registerSingleton(AuthService(dio:getIt<Dio>()));
  getIt.registerSingleton(AuthBloc(getIt.get<AuthService>()));
  
  getIt.registerSingleton(FavouritesService(dio:getIt<Dio>()));
  getIt.registerSingleton(FavouritesBloc(getIt.get<FavouritesService>()));
  
  getIt.registerSingleton(talker);
}
