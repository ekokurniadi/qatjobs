import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/data/models/profile_candidate_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/entities/profile_candidate_entity.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/entities/resume_entity.codegen.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_get_profile_usecase.dart';
import 'package:qatjobs/features/profile/candidate/domain/usecases/candidate_update_general_profile_usecase.dart';

part 'profile_candidate_event.dart';
part 'profile_candidate_state.dart';
part 'profile_candidate_bloc.freezed.dart';

@injectable
class ProfileCandidateBloc
    extends Bloc<ProfileCandidateEvent, ProfileCandidateState> {
  final CandidateGetProfile _candidateGetProfile;
  final CandidateUpdateGeneralProfile _candidateUpdateGeneralProfile;

  ProfileCandidateBloc(
    this._candidateGetProfile,
    this._candidateUpdateGeneralProfile,
  ) : super(ProfileCandidateState.initial()) {
    on<_GetGeneralProfileEvent>(_onGetGeneralProfile);
    on<_UpdateGeneralProfileEvent>(_onUpdateGeneralProfile);
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
          message: 'General profile updated'
        ),
      ),
    );
  }
}
