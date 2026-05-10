import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_menu_use_case.dart';
import 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  final GetMenuUseCase _getMenuUseCase;

  MenuCubit(this._getMenuUseCase) : super(MenuInitial());

  Future<void> fetchMenu(String tableId) async {
    emit(MenuLoading());

    final result = await _getMenuUseCase.execute(tableId);

    result.fold((failure) => emit(MenuError(failure.message)), (menuData) {
      if (menuData.categories.isEmpty || menuData.items.isEmpty) {
        emit(MenuEmpty());
      } else {
        // Sort category berdasar sortOrder
        menuData.categories.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
        emit(MenuLoaded(menuData));
      }
    });
  }
}

