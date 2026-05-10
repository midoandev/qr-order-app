import 'package:dartz/dartz.dart';
import 'package:qrorder/domain/entities/menu_data_entity.dart';
import '../../core/networks/error/failure.dart';
import '../repositories/menu_repository.dart';

class GetMenuUseCase {
  final MenuRepository repository;

  GetMenuUseCase(this.repository);

  Future<Either<Failure, MenuDataEntity>> execute(String tableId) async {
    return await repository.getMenuData(tableId);
  }
}
