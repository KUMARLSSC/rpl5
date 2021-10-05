import 'package:get_it/get_it.dart';
import 'package:rpl5/services/api_services.dart';
import 'package:rpl5/services/navigation_service.dart';
import 'package:rpl5/services/practical_service.dart';
import 'services/dialog_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => PracticalService());
  locator.registerLazySingleton(() => Api());
}
