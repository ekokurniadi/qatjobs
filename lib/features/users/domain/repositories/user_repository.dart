import 'package:dartz/dartz.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';

abstract class UserRepository {
  Future<Either<Failures, UserModel?>> getLogedinUser(NoParams params);
}
