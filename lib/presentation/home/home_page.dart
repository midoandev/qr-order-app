import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qrorder/presentation/home/widgets/setting_actions.dart';
import 'package:qrorder/presentation/ongoing_order/ongoing_order_page.dart';
import '../../core/extensions/localizations_extension.dart';
import '../../core/extensions/theme_extention.dart';
import '../scanner/scanner_page.dart';
import 'cubits/home_cubit.dart';
import 'cubits/home_state.dart';
import 'widgets/build_center_action.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadOngoingOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final hasOrders = state.orders.isNotEmpty;
        return Scaffold(
          appBar: AppBar(
            title: Text(context.s.app_title),
            actions: [const SettingActions()],
          ),
          floatingActionButton: hasOrders
              ? FloatingActionButton.extended(
                  onPressed: () => context.push(ScannerPage.route),
                  icon: const Icon(Icons.camera_alt),
                  label: Text(context.s.scan_button),
                )
              : null,
          body: RefreshIndicator(
            onRefresh: () => context.read<HomeCubit>().loadOngoingOrders(),
            child: CustomScrollView(
              slivers: [
                if (state.isLoading && !hasOrders)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  ),

                // List Pesanan Aktif
                if (hasOrders)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                    // Padding bawah agar tidak tertutup FAB
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final order = state.orders[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: Icon(
                              Icons.restaurant,
                              color: context.colorScheme.primary,
                            ),
                            title: Text("Order #${order.id.split('-').last}"),
                            subtitle: Text(
                              "${context.s.table_label} ${order.tableId} • ${order.status}",
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.push(
                              OngoingOrderPage.route,
                              extra: order,
                            ),
                          ),
                        );
                      }, childCount: state.orders.length),
                    ),
                  ),

                // Tampilan Tengah (Welcome) hanya jika pesanan kosong
                if (!hasOrders && !state.isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: BuildCenterAction(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
