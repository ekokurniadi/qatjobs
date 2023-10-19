import 'package:dartz/dartz.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/home/data/models/home_models.codegen.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failures, HomeModels>> getFrontData(NoParams params);
}
