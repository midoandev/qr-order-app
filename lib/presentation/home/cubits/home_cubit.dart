import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_active_orders_use_case.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetActiveOrdersUseCase _getActiveOrdersUseCase;

  HomeCubit(this._getActiveOrdersUseCase) : super(const HomeState());

  Future<void> loadOngoingOrders() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getActiveOrdersUseCase.execute();
    result.fold(
          (f) => emit(state.copyWith(isLoading: false, orders: [])),
          (orders) => emit(state.copyWith(isLoading: false, orders: orders)),
    );
  }
}