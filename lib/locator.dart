import 'package:couple_app_v3/services/authentication.dart';
import 'package:couple_app_v3/services/chat_service.dart';
import 'package:couple_app_v3/services/repository_service.dart';
import 'package:couple_app_v3/services/song_service.dart';
import 'package:get_it/get_it.dart';
GetIt locator = GetIt.instance;
Future  setupLocator() async{
  locator.registerLazySingleton(()=>Authentication());
  locator.registerLazySingleton(()=> Repository());
  locator.registerLazySingleton(() => ChatService());
  locator.registerLazySingleton(() => SongService());
}