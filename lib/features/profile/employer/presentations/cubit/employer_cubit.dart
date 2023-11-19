import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';
import 'package:qatjobs/features/profile/employer/data/models/job_application_models.codegen.dart';
import 'package:qatjobs/features/profile/employer/data/models/job_request_params.codegen.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/change_password_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/get_job_applicant_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/get_jobs_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/get_profile_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/update_job_status_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/update_job_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/update_profile_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/update_company_profile_usecase.dart';

part 'employer_state.dart';
part 'employer_cubit.freezed.dart';

@injectable
class EmployerCubit extends Cubit<EmployerState> {
  final GetProfileEmployerUserCase _getProfileEmployerUserCase;
  final EmployerUpdateProfile _employerUpdateProfile;
  final EmployerChangePasswordUseCase _changePasswordUseCase;
  final EmployerUpdateProfileCompany _updateProfileCompany;
  final GetJobsEmployerUserCase _getJobsEmployerUserCase;
  final UpdateJobStatus _updateJobStatus;
  final GetJobApplicantCase _getJobApplicantCase;
  final UpdateJobUseCase _updateJobUseCase;

  EmployerCubit(
    this._getProfileEmployerUserCase,
    this._employerUpdateProfile,
    this._changePasswordUseCase,
    this._updateProfileCompany,
    this._getJobsEmployerUserCase,
    this._updateJobStatus,
    this._getJobApplicantCase,
    this._updateJobUseCase,
  ) : super(EmployerState.initial());

  Future<void> updateJobUseCase(JobModel params) async {
    emit(state.copyWith(status: EmployerStatus.loading));

    final result = await _updateJobUseCase(params);

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: EmployerStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: EmployerStatus.updateJob,
          message: 'Success Update Job',
        ),
      ),
    );
  }

  Future<void> getApplicant(int id) async {
    emit(state.copyWith(status: EmployerStatus.loading));

    final result = await _getJobApplicantCase(id);

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: EmployerStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: EmployerStatus.getJobApplicant,
          jobApplicants: r,
        ),
      ),
    );
  }

  Future<void> updateJobStatus(UpdateJobStatusParams params) async {
    emit(state.copyWith(status: EmployerStatus.loading));

    final result = await _updateJobStatus(params);

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: EmployerStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
            status: EmployerStatus.updateJobStatus,
            message: 'Success Update Job Status'),
      ),
    );
  }

  Future<void> searchJobs(
    JobRequestParams params, {
    bool isReset = false,
  }) async {
    final result = await _getJobsEmployerUserCase(params);
    if (isReset) {
      state.jobs.clear();
    }
    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: EmployerStatus.failure,
        ),
      ),
      (r) => r.isEmpty
          ? emit(
              state.copyWith(
                hasReachMax: true,
                status: EmployerStatus.jobLoaded,
                jobs: [],
              ),
            )
          : emit(
              state.copyWith(
                jobs: r,
                status: EmployerStatus.jobLoaded,
              ),
            ),
    );
  }

  Future<void> getJobs(
    JobRequestParams params, {
    bool isReset = false,
  }) async {
    final result = await _getJobsEmployerUserCase(params);
    if (isReset) {
      state.jobs.clear();
    }
    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: EmployerStatus.failure,
        ),
      ),
      (r) => r.isEmpty
          ? emit(
              state.copyWith(
                hasReachMax: true,
                status: EmployerStatus.jobLoaded,
                jobs: !GlobalHelper.isEmpty(params.q) ? r : state.jobs,
              ),
            )
          : emit(
              state.copyWith(
                jobs: !GlobalHelper.isEmpty(params.q)
                    ? r
                    : (state.jobs + r).toSet().toList(),
                status: EmployerStatus.jobLoaded,
              ),
            ),
    );
  }

  Future<void> getProfile() async {
    emit(state.copyWith(status: EmployerStatus.loading));

    final result = await _getProfileEmployerUserCase(NoParams());

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: EmployerStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: EmployerStatus.getProfileSuccess,
          companyModel: r,
        ),
      ),
    );
  }

  Future<void> updateProfile(EmployerProfileRequestParams params) async {
    emit(state.copyWith(status: EmployerStatus.loading));

    final result = await _employerUpdateProfile(params);

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: EmployerStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
            status: EmployerStatus.updateProfileSuccess,
            message: 'Update Profile Success'),
      ),
    );
  }

  Future<void> changePassword(ChangePasswordRequestParams params) async {
    emit(state.copyWith(status: EmployerStatus.loading));

    final result = await _changePasswordUseCase(params);

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: EmployerStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: EmployerStatus.changePasswordSuccess,
          message: 'Change Password Success',
        ),
      ),
    );
  }

  Future<void> updateProfileCompany(CompanyModel params) async {
    emit(state.copyWith(status: EmployerStatus.loading));

    final result = await _updateProfileCompany(params);

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: EmployerStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: EmployerStatus.updateProfileCompanySuccess,
          message: 'Update Company Profile Success',
        ),
      ),
    );
  }
}
