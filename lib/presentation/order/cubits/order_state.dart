import '../../../domain/entities/order_entity.dart';

abstract class OrderState {
  const OrderState();
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final OrderEntity order;
  const OrderLoaded(this.order);
}

class OrderError extends OrderState {
  final String message;
  const OrderError(this.message);
}