part of 'profile_candidate_bloc.dart';

@freezed
class ProfileCandidateEvent with _$ProfileCandidateEvent {
  const factory ProfileCandidateEvent.getGeneralProfile() =
      _GetGeneralProfileEvent;
  const factory ProfileCandidateEvent.updateGeneralProfile(
    GeneralProfileRequestParams generalProfileRequestParams,
  ) = _UpdateGeneralProfileEvent;
}
