import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc_dependencies.dart';
import 'local_service_dependencies.dart';
import 'network_dependencies.dart';
import 'page_dependencies.dart';
import 'remote_service_dependencies.dart';
import 'repository_dependencies.dart';

class AppDependencies {
  static GetIt get injector => GetIt.I;

  static Future<void> init() async {
    // register local storage
    final sharedPreferences = await SharedPreferences.getInstance();
    injector.registerLazySingleton(() => sharedPreferences);

    await NetworkDependencies.setup(injector);
    await RemoteServiceDependencies.setup(injector);
    await LocalServiceDependencies.setup(injector);
    await RepositoryDependencies.setup(injector);
    await BlocDependencies.setup(injector);
    await PageDependencies.setup(injector);
  }
}
