import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qrorder/presentation/cart/cart_page.dart';
import 'package:qrorder/presentation/cart/cubits/cart_cubit.dart';
import 'package:qrorder/presentation/home/cubits/home_cubit.dart';
import 'package:qrorder/presentation/order/cubits/order_cubit.dart';
import 'package:qrorder/presentation/order/order_page.dart';
import 'package:qrorder/presentation/order/widgets/order_success.dart';

import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../presentation/home/home_page.dart';
import '../../presentation/menu/cubits/menu_cubit.dart';
import '../../presentation/menu/menu_page.dart';
import '../../presentation/ongoing_order/ongoing_order_page.dart';
import '../../presentation/scanner/cubits/scanner_cubit.dart';
import '../../presentation/scanner/scanner_page.dart';
import '../di/injection.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: HomePage.route,
    routes: [
      GoRoute(
        path: HomePage.route,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => getIt<HomeCubit>(),
            child: const HomePage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: ScannerPage.route,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => getIt<ScannerCubit>(),
            child: const ScannerPage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: MenuPage.route,
        pageBuilder: (context, state) {
          final tableId = state.extra as String;
          return CustomTransitionPage(
            key: state.pageKey,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => getIt<MenuCubit>()),
                BlocProvider(create: (_) => getIt<CartCubit>()),
              ],
              child: MenuPage(tableId: tableId),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: CartPage.route,
        pageBuilder: (context, state) {
          final tableId = state.extra as String;
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (_) => getIt<CartCubit>(),
              child: CartPage(tableId: tableId),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
                    ),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: OrderPage.route,
        pageBuilder: (context, state) {
          final cart = state.extra as CartEntity;
          return CustomTransitionPage(
            key: state.pageKey,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => getIt<OrderCubit>()),
                BlocProvider(create: (_) => getIt<CartCubit>()),
              ],
              child: OrderPage(cart: cart),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: OrderSuccess.route,
        pageBuilder: (context, state) {
          final order = state.extra as OrderEntity;
          return CustomTransitionPage(
            key: state.pageKey,
            child: OrderSuccess(order: order),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return ScaleTransition(
                    scale: animation.drive(
                      Tween(
                        begin: 0.8,
                        end: 1.0,
                      ).chain(CurveTween(curve: Curves.elasticOut)),
                    ),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
          );
        },
      ),
      GoRoute(
        path: OngoingOrderPage.route,
        pageBuilder: (context, state) {
          final order = state.extra as OrderEntity;
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (_) => getIt<HomeCubit>(),
              child: OngoingOrderPage(order: order),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: child,
                  );
                },
          );
        },
      ),
    ],
  );
}
