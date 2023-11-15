import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/employer_type/data/models/employer_type_model.codegen.dart";

abstract class EmployerTypeRemoteDataSource {
  Future<Either<Failures, List<EmployerTypeModel>>> getEmployerType(NoParams params);
}
