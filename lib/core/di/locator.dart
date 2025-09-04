import 'package:get_it/get_it.dart';
import '../logging/logger.dart';
import '../network/api_client.dart';
import '../storage/kv_store.dart';
import '../config/env.dart';
import '../../data/datasources/local/loyalty_local_ds.dart';
import '../../data/datasources/remote/loyalty_remote_ds.dart';
import '../../data/repositories/loyalty_repository_impl.dart';
import '../../domain/repositories/loyalty_repository.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Config
  sl.registerSingleton<Env>(Env.fromPlatform());

  // Logging
  sl.registerLazySingleton<AppLogger>(() => AppLogger.sl());

  // Storage
  sl.registerLazySingleton<KVStore>(() => KVStoreImpl());

  // Network
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Env>().baseUrl));

  // Data sources
  sl.registerLazySingleton<LoyaltyRemoteDS>(() => LoyaltyRemoteDS(sl<ApiClient>()));
  sl.registerLazySingleton<LoyaltyLocalDS>(() => LoyaltyLocalDS(sl<KVStore>()));

  // Repository (depends on abstractions; returned as interface)
  sl.registerLazySingleton<LoyaltyRepository>(
        () => LoyaltyRepositoryImpl(
      remote: sl<LoyaltyRemoteDS>(),
      local: sl<LoyaltyLocalDS>(),
    ),
  );
}
