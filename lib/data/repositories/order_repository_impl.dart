import 'package:dartz/dartz.dart';
import 'package:qrorder/domain/entities/order_entity.dart';
import '../../core/networks/error/failure.dart';
import '../../domain/entities/order_request_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasource/order_remote_data_source.dart';
import '../models/order_request_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, OrderEntity>> submitOrder(
    OrderRequestEntity request,
  ) async {
    final model = OrderRequestModel.fromEntity(request);
    final res = await _remoteDataSource.submitOrder(model);
    return res.fold((l) => Left(l), (r) {
      return Right(r.toEntity());
    });
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderStatus(int orderId) async {
    final res = await _remoteDataSource.getOrderStatus(orderId);
    return res.fold((l) => Left(l), (r) {
      return Right(r.toEntity());
    });
  }
}
