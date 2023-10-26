import 'package:dartz/dartz.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/features/auth/data/models/login_model.codegen.dart';
import 'package:qatjobs/features/auth/domain/usecases/login_usecase.dart';
import 'package:qatjobs/features/auth/domain/usecases/register_usecase.dart';

abstract class AuthRepository{
  Future<Either<Failures,LoginModel>> login(LoginRequestParams params);
  Future<Either<Failures, bool>> register(RegisterRequestParam params);
}