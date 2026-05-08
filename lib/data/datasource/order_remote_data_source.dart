import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qrorder/data/models/order_request_model.dart';

import '../../core/networks/error/failure.dart';
import '../models/order_model.dart';

class OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSource(this.dio);

  Future<Either<Failure, OrderModel>> submitOrder(
    OrderRequestModel payload,
  ) async {
    try {
      final response = await dio.post('/api/v1/orders', data: payload.toJson());

      final model = OrderModel.fromJson(response.data as Map<String, dynamic>);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Gagal mengirim pesanan"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }


  Future<Either<Failure, OrderModel>> getOrderStatus(int orderId) async {
    try {
      final response = await dio.get('/api/v1/orders/$orderId');
      final model = OrderModel.fromJson(response.data as Map<String, dynamic>);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Gagal mengambil status pesanan"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
