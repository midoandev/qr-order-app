import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:qrorder/core/env/env_config.dart';
import 'package:qrorder/domain/repositories/cart_repository.dart';
import 'package:qrorder/domain/usecases/add_to_cart_use_case.dart';
import 'package:qrorder/domain/usecases/get_cart_use_case.dart';
import 'package:qrorder/domain/usecases/update_item_details_use_case.dart';
import 'package:qrorder/presentation/menu/cubits/menu_cubit.dart';
import 'package:qrorder/presentation/scanner/cubits/scanner_cubit.dart';

import '../../data/datasources/cart_local_data.dart';
import '../../data/datasources/ordering_remote_data_source.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../data/repositories/menu_repository_impl.dart';
import '../../domain/repositories/menu_repository.dart';
import '../../domain/usecases/get_menu_use_case.dart';
import '../../domain/usecases/update_cart_quantity_use_case.dart';
import '../../presentation/cart/cubits/cart_cubit.dart';
import '../../presentation/settings/settings_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await Env.init();
  getIt.registerSingleton<EnvConfig>(Env.config);

  getIt.registerLazySingleton<AssetBundle>(() => rootBundle);

  getIt.registerLazySingleton(() => SettingsCubit());

  // Data Layer
  getIt.registerLazySingleton<CartLocalData>(() => CartLocalDataImpl());

  getIt.registerLazySingleton<OrderingRemoteDataSource>(
    () => OrderingRemoteDataSourceImpl(getIt<AssetBundle>()),
  );
  getIt.registerLazySingleton<MenuRepository>(
    () => MenuRepositoryImpl(getIt<OrderingRemoteDataSource>()),
  );

  // Domain Layer
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(getIt<CartLocalData>()),
  );
  getIt.registerLazySingleton<GetMenuUseCase>(
    () => GetMenuUseCase(getIt<MenuRepository>()),
  );
  // Cart Use Cases
  getIt.registerLazySingleton(() => GetCartUseCase(getIt()));
  getIt.registerLazySingleton(() => AddToCartUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateCartQuantityUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateItemDetailsUseCase(getIt()));

  // Presentation Layer
  getIt.registerFactory<ScannerCubit>(() => ScannerCubit());
  getIt.registerFactory<MenuCubit>(() => MenuCubit(getIt()));
  getIt.registerFactory(() => CartCubit(getIt(), getIt(), getIt(), getIt()));
}
