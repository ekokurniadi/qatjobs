import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/change_password_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/get_profile_usecase.dart';
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
  EmployerCubit(
    this._getProfileEmployerUserCase,
    this._employerUpdateProfile,
    this._changePasswordUseCase,
    this._updateProfileCompany,
  ) : super(EmployerState.initial());

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
          status: EmployerStatus.updateProfileSuccess,
          message: 'Update Profile Success',
        ),
      ),
    );
  }
}
