import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/data/datasources/remote/profile_candidate_remote_datasource.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_education_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_experience_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/profile_candidate_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/resume_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/repositories/candidate_profile_repository.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_change_password_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_update_general_profile_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_update_profile_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_upload_resume_usecase.dart';

@LazySingleton(as: CandidateProfileRepository)
class CandidateProfileRepositoryImpl implements CandidateProfileRepository {
  final ProfileCandidateRemoteDataSource _dataSource;

  const CandidateProfileRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failures, bool>> changePassword(
    ChangePasswordRequestParams params,
  ) async {
    return await _dataSource.changePassword(params);
  }

  @override
  Future<Either<Failures, ProfileCandidateModels>> getProfile(
    NoParams params,
  ) async {
    return await _dataSource.getProfile(params);
  }

  @override
  Future<Either<Failures, bool>> updateProfile(
      ChangeProfileRequestParams params) async {
    return await _dataSource.updateProfile(params);
  }

  @override
  Future<Either<Failures, List<ResumeModels>>> getResume(
    NoParams params,
  ) async {
    return await _dataSource.getResume(params);
  }

  @override
  Future<Either<Failures, bool>> uploadResume(
      ResumeRequestParams params) async {
    return await _dataSource.uploadResume(params);
  }

  @override
  Future<Either<Failures, bool>> deleteResume(int resumeId) async {
    return await _dataSource.deleteResume(resumeId);
  }

  @override
  Future<Either<Failures, bool>> updateGeneralProfile(
    GeneralProfileRequestParams params,
  ) async {
    return await _dataSource.updateGeneralProfile(params);
  }

  @override
  Future<Either<Failures, List<CandidateExperienceModels>>> getExperiences(
    NoParams params,
  ) async {
    return await _dataSource.getExperiences(params);
  }

  @override
  Future<Either<Failures, bool>> addExperience(
      CandidateExperienceModels params) async {
    return await _dataSource.addExperience(params);
  }

  @override
  Future<Either<Failures, bool>> updateExperience(
      CandidateExperienceModels params) async {
    return await _dataSource.updateExperience(params);
  }

  @override
  Future<Either<Failures, bool>> deleteExperience(int id) async {
    return await _dataSource.deleteExperience(id);
  }

  @override
  Future<Either<Failures, bool>> addEducation(
      CandidateEducationModels params) async {
    return await _dataSource.addEducation(params);
  }

  @override
  Future<Either<Failures, List<CandidateEducationModels>>> getEducation(
      NoParams params) async {
    return await _dataSource.getEducation(params);
  }

  @override
  Future<Either<Failures, bool>> updateEducation(
      CandidateEducationModels params) async {
    return await _dataSource.updateEducation(params);
  }

  @override
  Future<Either<Failures, bool>> deleteEducation(int id) async {
    return await _dataSource.deleteEducation(id);
  }
}
