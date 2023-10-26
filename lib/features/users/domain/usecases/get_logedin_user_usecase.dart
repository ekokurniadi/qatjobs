import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';
import 'package:qatjobs/features/users/domain/repositories/user_repository.dart';

@injectable
class GetLogedinUserCase implements UseCase<UserModel?, NoParams> {
  final UserRepository _repository;

  const GetLogedinUserCase(this._repository);

  @override
  Future<Either<Failures, UserModel?>> call(NoParams params) async {
    return await _repository.getLogedinUser(params);
  }
}
