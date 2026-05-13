import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:qrorder/core/env/env_config.dart';
import 'package:qrorder/data/datasources/order_local_data.dart';
import 'package:qrorder/domain/repositories/cart_repository.dart';
import 'package:qrorder/domain/usecases/add_to_cart_use_case.dart';
import 'package:qrorder/domain/usecases/checkout_use_case.dart';
import 'package:qrorder/domain/usecases/clear_cart_use_case.dart';
import 'package:qrorder/domain/usecases/get_active_orders_use_case.dart';
import 'package:qrorder/domain/usecases/get_cart_use_case.dart';
import 'package:qrorder/domain/usecases/update_item_details_use_case.dart';
import 'package:qrorder/presentation/home/cubits/home_cubit.dart';
import 'package:qrorder/presentation/menu/cubits/menu_cubit.dart';
import 'package:qrorder/presentation/order/cubits/order_cubit.dart';
import 'package:qrorder/presentation/scanner/cubits/scanner_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/cart_local_data.dart';
import '../../data/datasources/ordering_remote_data_source.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../data/repositories/menu_repository_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/repositories/menu_repository.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/usecases/get_menu_use_case.dart';
import '../../domain/usecases/update_cart_quantity_use_case.dart';
import '../../presentation/cart/cubits/cart_cubit.dart';
import '../../presentation/settings/settings_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await Env.init();
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPrefs);

  getIt.registerSingleton<EnvConfig>(Env.config);

  getIt.registerLazySingleton<AssetBundle>(() => rootBundle);

  getIt.registerLazySingleton(() => SettingsCubit());
  getIt.registerLazySingleton(() => HomeCubit(getIt()));

  // Data Repositories
  getIt.registerLazySingleton<CartLocalData>(() => CartLocalDataImpl());
  getIt.registerLazySingleton<OrderLocalData>(() => OrderLocalDataImpl(getIt()));

  getIt.registerLazySingleton<OrderingRemoteDataSource>(
    () => OrderingRemoteDataSourceImpl(getIt<AssetBundle>()),
  );
  getIt.registerLazySingleton<MenuRepository>(
    () => MenuRepositoryImpl(getIt<OrderingRemoteDataSource>()),
  );
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(getIt()),
  );

  // USE CASE
  getIt.registerLazySingleton<GetMenuUseCase>(() => GetMenuUseCase(getIt()));
  getIt.registerLazySingleton<CheckoutUseCase>(() => CheckoutUseCase(getIt()));
  getIt.registerLazySingleton<GetActiveOrdersUseCase>(() => GetActiveOrdersUseCase(getIt()));

  // Cart Use Cases
  getIt.registerLazySingleton(() => GetCartUseCase(getIt()));
  getIt.registerLazySingleton(() => AddToCartUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateCartQuantityUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateItemDetailsUseCase(getIt()));
  getIt.registerLazySingleton(() => ClearCartUseCase(getIt()));

  // Presentation Layer
  getIt.registerFactory<ScannerCubit>(() => ScannerCubit());
  getIt.registerFactory<MenuCubit>(() => MenuCubit(getIt()));
  getIt.registerFactory(
    () => CartCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerFactory<OrderCubit>(() => OrderCubit(getIt()));
}
