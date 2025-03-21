import 'package:doggie_chef/src/feature/main/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencyInjection() {
  locator.registerLazySingleton(() => Repository());
}
