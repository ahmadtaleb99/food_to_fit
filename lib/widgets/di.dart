import 'package:food_to_fit/AppPreferences.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
final getIT = GetIt.instance;
Future<void> initAppModule() async {
  //shared prefs
  final _prefs = await SharedPreferences.getInstance();
  getIT.registerLazySingleton<SharedPreferences>(() => _prefs);


  //app prefs
  final _appPreferences = AppPreferences(getIT<SharedPreferences>());
  getIT.registerLazySingleton<AppPreferences>(() => _appPreferences);
}
