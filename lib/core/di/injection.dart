import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:qrorder/core/env/env_config.dart';
final sl = GetIt.instance;

Future<void> init() async {
  await Env.init();
  sl.registerSingleton<EnvConfig>(Env.config);


  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: Env.config.baseUrl, // Placeholder
        connectTimeout: const Duration(seconds: 5),
      ),
    ),
  );
}
