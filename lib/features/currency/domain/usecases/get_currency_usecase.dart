import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/currency/data/models/currency_model.codegen.dart";
import "package:qatjobs/features/currency/domain/repositories/currency_repository.dart";

@injectable
class GetCurrencyUseCase
    implements UseCase<List<CurrencyModel>, NoParams> {
  final CurrencyRepository currencyRepository;

  GetCurrencyUseCase(this.currencyRepository);

  @override
  Future<Either<Failures, List<CurrencyModel>>> call(
      NoParams params) async {
    return await currencyRepository.getCurrency(params);
  }
}
