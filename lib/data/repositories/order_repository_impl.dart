import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:qrorder/domain/entities/cart_item_entity.dart';
import '../../core/error/failure.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_local_data.dart';
import '../models/cart_item_model.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalData localData;

  OrderRepositoryImpl(this.localData);

  @override
  Future<Either<Failure, OrderEntity>> checkout({
    required String tableId,
    required List<CartItemEntity> cartItems,
  }) async {
    try {
      final double totalPrice = cartItems.fold(
        0,
        (sum, item) => sum + item.totalPrice,
      );

      final orderModel = OrderModel(
        id: "ORD-${DateTime.now().millisecondsSinceEpoch}",
        tableId: tableId,
        items: cartItems.map((item) => CartItemModel.fromEntity(item)).toList(),
        totalPrice: totalPrice,
        createdAt: DateTime.now(),
        status: "pending",
      );

      final result = await localData.saveOrder(orderModel);
      return Right(result.toEntity());
    } catch (e) {
      debugPrint('fdslkm $e');
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getActiveOrders() async {
    try {
      final models = await localData.getAllActiveOrders();
      // Kembalikan sebagai Entity ke Domain/Presentation
      return Right(models.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
