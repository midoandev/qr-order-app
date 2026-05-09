import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:qrorder/core/env/env_config.dart';

import '../../presentation/cubits/settings/settings_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  await Env.init();
  getIt.registerSingleton<EnvConfig>(Env.config);

  getIt.registerLazySingleton(() => SettingsCubit());
  getIt.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: Env.config.baseUrl, // Placeholder
        connectTimeout: const Duration(seconds: 5),
      ),
    ),
  );
}
