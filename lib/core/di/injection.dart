import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:qrorder/core/env/env_config.dart';
import 'package:qrorder/presentation/menu/cubits/menu_cubit.dart';
import 'package:qrorder/presentation/scanner/cubits/scanner_cubit.dart';

import '../../data/datasources/ordering_remote_data_source.dart';
import '../../data/repositories/menu_repository_impl.dart';
import '../../domain/repositories/menu_repository.dart';
import '../../domain/usecases/get_menu_use_case.dart';
import '../../presentation/settings/settings_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await Env.init();
  getIt.registerSingleton<EnvConfig>(Env.config);

  getIt.registerLazySingleton<AssetBundle>(() => rootBundle);

  getIt.registerLazySingleton(() => SettingsCubit());

  // Data Layer
  getIt.registerLazySingleton<OrderingRemoteDataSource>(
    () => OrderingRemoteDataSource(getIt<AssetBundle>()),
  );
  getIt.registerLazySingleton<MenuRepository>(
    () => MenuRepositoryImpl(getIt<OrderingRemoteDataSource>()),
  );

  // Domain Layer
  getIt.registerLazySingleton<GetMenuUseCase>(
    () => GetMenuUseCase(getIt<MenuRepository>()),
  );

  // Presentation Layer
  getIt.registerFactory<ScannerCubit>(() => ScannerCubit());
  getIt.registerFactory<MenuCubit>(() => MenuCubit(getIt<GetMenuUseCase>()));
}
