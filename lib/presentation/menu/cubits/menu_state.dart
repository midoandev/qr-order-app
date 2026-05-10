import 'package:equatable/equatable.dart';
import '../../../domain/entities/menu_data_entity.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object?> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final MenuDataEntity data;

  const MenuLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class MenuError extends MenuState {
  final String message;

  const MenuError(this.message);

  @override
  List<Object?> get props => [message];
}

class MenuEmpty extends MenuState {}
