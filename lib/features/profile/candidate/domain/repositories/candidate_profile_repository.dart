import 'package:dartz/dartz.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_experience_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/profile_candidate_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/resume_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_change_password_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_update_general_profile_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_update_profile_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_upload_resume_usecase.dart';

abstract class CandidateProfileRepository {
  Future<Either<Failures, bool>> changePassword(
    ChangePasswordRequestParams params,
  );
  Future<Either<Failures, ProfileCandidateModels>> getProfile(
    NoParams params,
  );
  Future<Either<Failures, bool>> updateProfile(
    ChangeProfileRequestParams params,
  );
  Future<Either<Failures, List<ResumeModels>>> getResume(
    NoParams params,
  );
  Future<Either<Failures, bool>> uploadResume(
    ResumeRequestParams params,
  );
  Future<Either<Failures, bool>> deleteResume(
    int resumeId,
  );
  Future<Either<Failures, bool>> updateGeneralProfile(
    GeneralProfileRequestParams params,
  );
  Future<Either<Failures, List<CandidateExperienceModels>>> getExperiences(
    NoParams params,
  );
  Future<Either<Failures, bool>> addExperience(
    CandidateExperienceModels params,
  );
}
