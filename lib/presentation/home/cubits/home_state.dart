import 'package:equatable/equatable.dart';
import '../../../domain/entities/order_entity.dart';

class HomeState extends Equatable {
  final List<OrderEntity> orders;
  final bool isLoading;
  final String? errorMessage;

  const HomeState({
    this.orders = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  HomeState copyWith({
    List<OrderEntity>? orders,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [orders, isLoading, errorMessage];
}