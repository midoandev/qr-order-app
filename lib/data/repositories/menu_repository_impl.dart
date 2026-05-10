import 'package:dartz/dartz.dart';

import 'package:qrorder/core/networks/error/failure.dart';

import '../../domain/entities/menu_data_entity.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/ordering_remote_data_source.dart';

class MenuRepositoryImpl implements MenuRepository {
  final OrderingRemoteDataSource _remoteDataSource;

  MenuRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, MenuDataEntity>> getMenuData(String tableId) async {
    final res = await _remoteDataSource.getMenusByTable(tableId);
    return res.fold((l) => Left(l), (r) {
      return Right(r.toEntity());
    });
  }
}
