import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qrorder/presentation/cart/cart_page.dart';
import 'package:qrorder/presentation/cart/cubits/cart_cubit.dart';

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
          final tableId = state.extra as String;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<MenuCubit>()),
              BlocProvider(create: (_) => getIt<CartCubit>()),
            ],
            child: MenuPage(tableId: tableId),
          );
        },
      ),
      GoRoute(
        path: CartPage.route,
        builder: (context, state) {
          final tableId = state.extra as String;
          return BlocProvider(
            create: (_) => getIt<CartCubit>(),
            child: CartPage(tableId: tableId),
          );
        },
      ),
    ],
  );
}
