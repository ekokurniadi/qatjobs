import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import 'package:qatjobs/features/currency/data/datasources/remote/currency_remote_datasource.dart';
import "package:qatjobs/features/currency/data/models/currency_model.codegen.dart";
import 'package:qatjobs/features/currency/domain/repositories/currency_repository.dart';

@LazySingleton(as:CurrencyRepository)
class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource _currencyRemoteDataSource;

  const CurrencyRepositoryImpl({
    required CurrencyRemoteDataSource currencyRemoteDataSource,
  }) : _currencyRemoteDataSource = currencyRemoteDataSource;

  @override
  Future<Either<Failures, List<CurrencyModel>>> getCurrency(
      NoParams params) async {
    return await _currencyRemoteDataSource.getCurrency(params);
  }
}
