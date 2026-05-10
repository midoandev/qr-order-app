import 'package:equatable/equatable.dart';

abstract class ScannerState extends Equatable {
  const ScannerState();
  @override
  List<Object?> get props => [];
}

class ScannerInitial extends ScannerState {}

class ScannerDetected extends ScannerState {
  final String tableId;
  const ScannerDetected(this.tableId);

  @override
  List<Object?> get props => [tableId];
}