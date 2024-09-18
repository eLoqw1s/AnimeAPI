import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:android_dev/di/di.dart';
void setUpDio() {
  dio.options.baseUrl = 'https://anime-db.p.rapidapi.com/'; // общая часть адресов запросов
  dio.options.queryParameters.addAll({
    'rapidapi-key': '', // сюда нужно будет подставить ключ/токен, выданный при регистрации
  });
  dio.options.connectTimeout = const Duration(minutes: 1);
  dio.options.receiveTimeout = const Duration(minutes: 1);
  dio.interceptors.addAll([
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
      ),
    ),
  ]);
}
