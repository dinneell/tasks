import 'package:get_it/get_it.dart';
import 'services/my_service.dart';


final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<MyService>(() => MyService());
}

