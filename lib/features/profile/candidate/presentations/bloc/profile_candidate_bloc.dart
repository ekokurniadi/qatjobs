import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_education_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_experience_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/profile_candidate_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/resume_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/entities/candidate_education_entity.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/entities/candidate_experience_entity.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/entities/profile_candidate_entity.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/entities/resume_entity.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_add_education_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_add_experience_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_delete_education_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_delete_experience_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_delete_resume_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_get_education_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_get_experience_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_get_profile_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_get_resume_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_update_education_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_update_experience_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_update_general_profile_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_upload_resume_usecase.dart';

part 'profile_candidate_event.dart';
part 'profile_candidate_state.dart';
part 'profile_candidate_bloc.freezed.dart';

@injectable
class ProfileCandidateBloc
    extends Bloc<ProfileCandidateEvent, ProfileCandidateState> {
  final CandidateGetProfile _candidateGetProfile;
  final CandidateUpdateGeneralProfile _candidateUpdateGeneralProfile;
  final CandidateGetResume _getResume;
  final CandidateDeleteResume _deleteResume;
  final CandidateUploadResume _uploadResume;
  final CandidateGetExperienceUseCase _getExperienceUseCase;
  final CandidateAddExperienceUseCase _addExperienceUseCase;
  final CandidateUpdateExperienceUseCase _updateExperienceUseCase;
  final CandidateDeleteExperienceUseCase _deleteExperienceUseCase;
  final CandidateAddEducationUseCase _addEducationUseCase;
  final CandidateGetEducationUseCase _getEducationUseCase;
  final CandidateUpdateEducationUseCase _updateEducationUseCase;
  final CandidateDeleteEducationUseCase _deleteEducationUseCase;

  ProfileCandidateBloc(
    this._candidateGetProfile,
    this._candidateUpdateGeneralProfile,
    this._getResume,
    this._deleteResume,
    this._uploadResume,
    this._getExperienceUseCase,
    this._addExperienceUseCase,
    this._updateExperienceUseCase,
    this._deleteExperienceUseCase,
    this._addEducationUseCase,
    this._getEducationUseCase,
    this._updateEducationUseCase,
    this._deleteEducationUseCase,
  ) : super(ProfileCandidateState.initial()) {
    on<_GetGeneralProfileEvent>(_onGetGeneralProfile);
    on<_UpdateGeneralProfileEvent>(_onUpdateGeneralProfile);
    on<_GetResumeEvent>(_onGetResume);
    on<_DeleteResumeEvent>(_onDeleteResume);
    on<_UploadResumeEvent>(_onUploadResume);
    on<_GetExperiencesEvent>(_ongetExperience);
    on<_AddExperiencesEvent>(_onAddExperience);
    on<_UpdateExperiencesEvent>(_onUpdateExperience);
    on<_DeleteExpEvent>(_onDeleteExperience);
    on<_GetEducationEvent>(_ongetEducation);
    on<_AddEducationEvent>(_onAddEducation);
    on<_UpdateEducationEvent>(_onUpdateEducation);
    on<_DeleteEducationEvent>(_onDeleteEducation);
  }

  FutureOr<void> _onGetGeneralProfile(
    _GetGeneralProfileEvent event,
    Emitter<ProfileCandidateState> emit,
  ) async {
    emit(state.copyWith(status: ProfileCandidateStatus.loading));

    final result = await _candidateGetProfile(NoParams());

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.getGeneralProfile,
          generalProfile: r.toDomain(),
        ),
      ),
    );
  }

  FutureOr<void> _onGetResume(
    _GetResumeEvent event,
    Emitter<ProfileCandidateState> emit,
  ) async {
    emit(state.copyWith(status: ProfileCandidateStatus.loading));

    final result = await _getResume(NoParams());

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
            status: ProfileCandidateStatus.getResume,
            resumes: List.from(
              r.map(
                (e) => e.toDomain(),
              ),
            )),
      ),
    );
  }

  FutureOr<void> _onUpdateGeneralProfile(
    _UpdateGeneralProfileEvent event,
    Emitter<ProfileCandidateState> emit,
  ) async {
    emit(state.copyWith(status: ProfileCandidateStatus.loading));

    final result =
        await _candidateUpdateGeneralProfile(event.generalProfileRequestParams);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
            status: ProfileCandidateStatus.generalProfileSaved,
            message: 'General profile updated'),
      ),
    );
  }

  FutureOr<void> _onDeleteResume(
    _DeleteResumeEvent event,
    Emitter<ProfileCandidateState> emit,
  ) async {
    emit(state.copyWith(status: ProfileCandidateStatus.loading));

    final result = await _deleteResume(event.id);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.deleteResume,
          message: 'Delete Success',
        ),
      ),
    );
  }

  FutureOr<void> _onUploadResume(
    _UploadResumeEvent event,
    Emitter<ProfileCandidateState> emit,
  ) async {
    emit(state.copyWith(status: ProfileCandidateStatus.loading));

    final result = await _uploadResume(event.params);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.insertResume,
          message: 'Successfully',
        ),
      ),
    );
  }

  FutureOr<void> _ongetExperience(
    _GetExperiencesEvent event,
    Emitter<ProfileCandidateState> emit,
  ) async {
    emit(state.copyWith(status: ProfileCandidateStatus.loading));

    final result = await _getExperienceUseCase(NoParams());

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
            status: ProfileCandidateStatus.getExperiences,
            experiences: List.from(
              r.map(
                (e) => e.toDomain(),
              ),
            )),
      ),
    );
  }

  FutureOr<void> _onAddExperience(
    _AddExperiencesEvent event,
    Emitter<ProfileCandidateState> emit,
  ) async {
    emit(state.copyWith(status: ProfileCandidateStatus.loading));

    final result = await _addExperienceUseCase(event.params);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.addExperiences,
          message: 'Successfully',
        ),
      ),
    );
  }

  FutureOr<void> _onUpdateExperience(
    _UpdateExperiencesEvent event,
    Emitter<ProfileCandidateState> emit,
  ) async {
    emit(state.copyWith(status: ProfileCandidateStatus.loading));

    final result = await _updateExperienceUseCase(event.params);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.updateExperiences,
          message: 'Successfully',
        ),
      ),
    );
  }

  FutureOr<void> _onDeleteExperience(
    _DeleteExpEvent event,
    Emitter<ProfileCandidateState> emit,
  ) async {
    emit(state.copyWith(status: ProfileCandidateStatus.loading));

    final result = await _deleteExperienceUseCase(event.id);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.deleteExperience,
          message: 'Delete Success',
        ),
      ),
    );
  }

  FutureOr<void> _ongetEducation(
    _GetEducationEvent event,
    Emitter<ProfileCandidateState> emit,
  ) async {
    emit(state.copyWith(status: ProfileCandidateStatus.loading));

    final result = await _getEducationUseCase(NoParams());

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
            status: ProfileCandidateStatus.getEducation,
            educations: List.from(
              r.map(
                (e) => e.toDomain(),
              ),
            )),
      ),
    );
  }

  FutureOr<void> _onAddEducation(
    _AddEducationEvent event,
    Emitter<ProfileCandidateState> emit,
  ) async {
    emit(state.copyWith(status: ProfileCandidateStatus.loading));

    final result = await _addEducationUseCase(event.params);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.addEducation,
          message: 'Successfully',
        ),
      ),
    );
  }

  FutureOr<void> _onUpdateEducation(
    _UpdateEducationEvent event,
    Emitter<ProfileCandidateState> emit,
  ) async {
    emit(state.copyWith(status: ProfileCandidateStatus.loading));

    final result = await _updateEducationUseCase(event.params);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.updateEducation,
          message: 'Successfully',
        ),
      ),
    );
  }

  FutureOr<void> _onDeleteEducation(
    _DeleteEducationEvent event,
    Emitter<ProfileCandidateState> emit,
  ) async {
    emit(state.copyWith(status: ProfileCandidateStatus.loading));

    final result = await _deleteEducationUseCase(event.id);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: ProfileCandidateStatus.deleteEducation,
          message: 'Delete Success',
        ),
      ),
    );
  }
}
