import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/home/data/models/home_models.codegen.dart';
import 'package:qatjobs/features/home/domain/repositories/home_repository.dart';

@injectable
class GetFrontDataUseCase  implements UseCase<HomeModels, NoParams> {
  final HomeRepository _repository;

  const GetFrontDataUseCase(this._repository);

  @override
  Future<Either<Failures, HomeModels>> call(NoParams params) async{
    return await _repository.getFrontData(params);
  }

}