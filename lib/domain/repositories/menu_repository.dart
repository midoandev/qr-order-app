import 'package:dartz/dartz.dart';
import 'package:qrorder/domain/entities/menu_data_entity.dart';
import '../../core/error/failure.dart';

abstract class MenuRepository {
  Future<Either<Failure, MenuDataEntity>> getMenuData(String tableId);
}