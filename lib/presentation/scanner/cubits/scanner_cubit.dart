import 'package:flutter_bloc/flutter_bloc.dart';
import 'scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit() : super(ScannerInitial());

  void onQrDetected(String rawValue) {
    if (isClosed) return;
    if (rawValue.startsWith("ipot://table/")) {
      final tableId = rawValue.split('/').last;
      emit(ScannerDetected(tableId));
    }
  }

  void reset() {
    emit(ScannerInitial());
  }
}