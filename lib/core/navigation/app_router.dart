import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/home/home_page.dart';
import '../../presentation/menu/cubits/menu_cubit.dart';
import '../../presentation/menu/menu_page.dart';
import '../../presentation/scanner/cubits/scanner_cubit.dart';
import '../../presentation/scanner/scanner_page.dart';
import '../di/injection.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: HomePage.route,
    routes: [
      GoRoute(
        path: HomePage.route,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: ScannerPage.route,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<ScannerCubit>(),
          child: const ScannerPage(),
        ),
      ),
      GoRoute(
        path: MenuPage.route,
        builder: (context, state) {
          final tableId = state.pathParameters['tableId'] ?? '';
          return BlocProvider(
            create: (_) => getIt<MenuCubit>(),
            child: MenuPage(tableId: tableId),
          );
        },
      ),
    ],
  );
}
