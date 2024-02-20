import 'package:get_it/get_it.dart';
import 'package:store_app/database/local_database_services.dart';
import 'package:store_app/database/reposetory/local_database_reposetory.dart';
import 'package:store_app/database/reposetory/local_database_reposetory_impl.dart';

final GetIt instance = GetIt.instance;

Future<void> initAppModules() async {
  instance.registerLazySingleton<LocalDatabaseReposetory>(
    () => const LocalDatabaseReposetoryImpl(),
  );

  instance.registerLazySingleton<LocalDatabaseServices>(
    () => LocalDatabaseServicesImpl(instance()),
  );
}
