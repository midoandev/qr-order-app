import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:qrorder/data/models/menu_data_model.dart';
import 'package:qrorder/data/models/order_request_model.dart';

import '../../core/error/failure.dart';
import '../models/order_model.dart';

abstract class OrderingRemoteDataSource {
  Future<Either<Failure, MenuDataModel>> getMenusByTable(String tableId);

  Future<Either<Failure, OrderModel>> submitOrder(OrderRequestModel payload);

  Future<Either<Failure, OrderModel>> getOrderStatus(int orderId);
}

class OrderingRemoteDataSourceImpl implements OrderingRemoteDataSource {
  final AssetBundle _bundle;

  OrderingRemoteDataSourceImpl(this._bundle);

  final String baseUrl = "assets/mock/menu.json";

  @override
  Future<Either<Failure, MenuDataModel>> getMenusByTable(String tableId) async {
    try {
      // Simulasi delay fetch data
      await Future.delayed(const Duration(milliseconds: 800));

      final String response = await _bundle.loadString(baseUrl);
      final Map<String, dynamic> data = json.decode(response);

      final MenuDataModel menuData = MenuDataModel.fromJson(data);

      if (menuData.restaurant.tableId != tableId) {
        return const Left(ServerFailure("Table ID is not match"));
      }
      return Right(menuData);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> submitOrder(
    OrderRequestModel payload,
  ) async {
    try {
      final String response = await _bundle.loadString(baseUrl);
      final Map<String, dynamic> data = json.decode(response);
      final model = OrderModel.fromJson(data);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Gagal mengirim pesanan"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> getOrderStatus(int orderId) async {
    try {
      final String response = await _bundle.loadString(baseUrl);
      final Map<String, dynamic> data = json.decode(response);
      final model = OrderModel.fromJson(data);
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Gagal mengambil status pesanan"));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
