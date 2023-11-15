import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/constant/url_constant.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/extensions/dio_response_extension.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/jobs_skill/data/models/jobs_skill_model.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/datasources/remote/profile_candidate_remote_datasource.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_education_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_experience_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/cv_builder_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/profile_candidate_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/profile_candidate_response_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/resume_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_change_password_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_update_general_profile_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_update_profile_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_upload_resume_usecase.dart';

@LazySingleton(as: ProfileCandidateRemoteDataSource)
class ProfileCandidateRemoteDataSourceImpl
    implements ProfileCandidateRemoteDataSource {
  final Dio _dio;
  const ProfileCandidateRemoteDataSourceImpl(this._dio);

  @override
  Future<Either<Failures, ProfileCandidateModels>> getProfile(
      NoParams params) async {
    try {
      final response = await _dio.get(URLConstant.candidateProfile);
      if (response.isOk) {
        final data = ProfileCandidateResponseModels(
          candidate: ProfileCandidateModels.fromJson(
            response.data['data']['candidate'],
          ),
          candidateSkill: List.from(
            response.data['data']['candidate_skill'].map(
              (e) => JobsSkillModel.fromJson(e),
            ),
          ),
        );
        final result = data.candidate.copyWith(
          candidateSkill: data.candidateSkill,
        );
        return right(result);
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> changePassword(
    ChangePasswordRequestParams params,
  ) async {
    try {
      final formData = FormData.fromMap(params.toJson());

      final response = await _dio.post(
        URLConstant.candidateChangePassword,
        data: formData,
      );
      if (response.isOk) {
        return right(true);
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> updateProfile(
      ChangeProfileRequestParams params) async {
    try {
      String fileName = '';
      Map<String, dynamic> paramToSend = {
        'first_name': params.firstName,
        'last_name': params.lastName,
        'email': params.email,
      };

      if (params.phone != null) {
        paramToSend['phone'] = params.phone;
      }

      if (params.image != null) {
        fileName = params.image!.path.split('/').last;
        paramToSend['image'] = await MultipartFile.fromFile(
          params.image!.path,
          filename: fileName,
        );
      }

      final response = await _dio.post(
        URLConstant.candidateUpdateProfile,
        data: FormData.fromMap(paramToSend),
      );
      if (response.isOk) {
        return right(true);
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<ResumeModels>>> getResume(
    NoParams params,
  ) async {
    try {
      final response = await _dio.get(URLConstant.candidateGetResume);
      if (response.isOk) {
        return right(List.from(
          response.data.map(
            (e) => ResumeModels.fromJson(e),
          ),
        ));
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> uploadResume(
      ResumeRequestParams params) async {
    try {
      String fileName = '';
      fileName = params.file.path.split('/').last;
      Map<String, dynamic> paramToSend = {
        'title': params.title,
        'is_default': params.isDefault,
        'file': await MultipartFile.fromFile(
          params.file.path,
          filename: fileName,
        ),
      };

      final response = await _dio.post(
        URLConstant.candidateGetResume,
        data: FormData.fromMap(paramToSend),
      );
      if (response.isOk) {
        return right(true);
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> deleteResume(int resumeId) async {
    try {
      final response = await _dio.delete(
        '${URLConstant.candidateGetResume}/$resumeId',
      );
      if (response.isOk) {
        return right(true);
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> updateGeneralProfile(
    GeneralProfileRequestParams params,
  ) async {
    try {
      final response = await _dio.post(
        URLConstant.candidateUpdateGeneralProfile,
        data: params.toJson(),
      );
      if (response.isOk) {
        return right(true);
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<CandidateExperienceModels>>> getExperiences(
    NoParams params,
  ) async {
    try {
      final response = await _dio.get(URLConstant.candidateGetExperiences);
      if (response.isOk) {
        return right(List.from(
          response.data.map(
            (e) => CandidateExperienceModels.fromJson(e),
          ),
        ));
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> addExperience(
      CandidateExperienceModels params) async {
    try {
      params.toJson().remove('id');
      params.toJson().remove('currenty_working');
      params.toJson().remove('candidate_id');
      params.toJson().putIfAbsent('country_id', () => '178');
      final response = await _dio.post(
        URLConstant.candidateGetExperiences,
        data: params.toJson(),
      );
      if (response.isOk) {
        return right(true);
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> updateExperience(
      CandidateExperienceModels params) async {
    try {
      Map<String, dynamic> paramsNew = params.toJson();
      paramsNew['country_id'] = 178;

      final response = await _dio.put(
        '${URLConstant.candidateGetExperiences}/${params.id}',
        data: paramsNew,
      );
      if (response.isOk) {
        return right(true);
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> deleteExperience(int id) async {
    try {
      final response = await _dio.delete(
        '${URLConstant.candidateGetExperiences}/$id',
      );
      if (response.isOk) {
        return right(true);
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> addEducation(
      CandidateEducationModels params) async {
    try {
      params.toJson().remove('id');
      final newParams = params.toJson();
      newParams['country_id'] = 178;
      final response = await _dio.post(
        URLConstant.candidateEducation,
        data: newParams,
      );
      if (response.isOk) {
        return right(true);
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<CandidateEducationModels>>> getEducation(
      NoParams params) async {
    try {
      final response = await _dio.get(URLConstant.candidateEducation);
      if (response.isOk) {
        return right(List.from(
          response.data.map(
            (e) => CandidateEducationModels.fromJson(e),
          ),
        ));
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> updateEducation(
      CandidateEducationModels params) async {
    try {
      final newParams = params.toJson();
      newParams['country_id'] = 178;
      final response = await _dio.put(
        '${URLConstant.candidateEducation}/${params.id}',
        data: newParams,
      );
      if (response.isOk) {
        return right(true);
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> deleteEducation(int id) async {
    try {
      final response = await _dio.delete(
        '${URLConstant.candidateEducation}/$id',
      );
      if (response.isOk) {
        return right(true);
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, CvBuilderResponseModels>> getCVBuilder(
    NoParams params,
  ) async {
    try {
      final response = await _dio.get(URLConstant.candidateCVBuilder);
      if (response.isOk) {
        return right(CvBuilderResponseModels.fromJson(response.data));
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
