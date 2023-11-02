part of 'profile_candidate_bloc.dart';

@freezed
class ProfileCandidateEvent with _$ProfileCandidateEvent {
  const factory ProfileCandidateEvent.getGeneralProfile() =
      _GetGeneralProfileEvent;
  const factory ProfileCandidateEvent.updateGeneralProfile(
    GeneralProfileRequestParams generalProfileRequestParams,
  ) = _UpdateGeneralProfileEvent;
  const factory ProfileCandidateEvent.getResume() = _GetResumeEvent;
  const factory ProfileCandidateEvent.deleteResume(int id) = _DeleteResumeEvent;
  const factory ProfileCandidateEvent.uploadResume(ResumeRequestParams params) =
      _UploadResumeEvent;
 const factory ProfileCandidateEvent.getExperiences() =
      _GetExperiencesEvent;
 const factory ProfileCandidateEvent.addExperiences(CandidateExperienceModels params) =
      _AddExperiencesEvent;
}
