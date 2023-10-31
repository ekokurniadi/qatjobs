import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/currency/data/models/currency_model.codegen.dart";

abstract class CurrencyRemoteDataSource {
  Future<Either<Failures, List<CurrencyModel>>> getCurrency(
      NoParams params);
}
