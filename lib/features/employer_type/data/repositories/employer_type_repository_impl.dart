import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/employer_type/data/datasources/remote/employer_type_remote_datasource.dart";
import "package:qatjobs/features/employer_type/data/models/employer_type_model.codegen.dart";
import "package:qatjobs/features/employer_type/domain/repositories/employer_type_repository.dart";

@LazySingleton(as: EmployerTypeRepository)
class EmployerTypeRepositoryImpl implements EmployerTypeRepository {
  final EmployerTypeRemoteDataSource _employerTypeRemoteDataSource;

  const EmployerTypeRepositoryImpl({
    required EmployerTypeRemoteDataSource employerTypeRemoteDataSource,
  }) : _employerTypeRemoteDataSource = employerTypeRemoteDataSource;

  @override
  Future<Either<Failures, List<EmployerTypeModel>>> getEmployerType(
      NoParams params) async {
    return await _employerTypeRemoteDataSource.getEmployerType(params);
  }
}
