part of 'profile_candidate_bloc.dart';

@freezed
class ProfileCandidateEvent with _$ProfileCandidateEvent {
  factory ProfileCandidateEvent.getGeneralProfile(
      {bool? isForCheckCompleting}) = _GetGeneralProfileEvent;
  const factory ProfileCandidateEvent.updateGeneralProfile(
    GeneralProfileRequestParams generalProfileRequestParams,
  ) = _UpdateGeneralProfileEvent;
  const factory ProfileCandidateEvent.getResume() = _GetResumeEvent;
  const factory ProfileCandidateEvent.deleteResume(int id) = _DeleteResumeEvent;
  const factory ProfileCandidateEvent.uploadResume(ResumeRequestParams params) =
      _UploadResumeEvent;
  const factory ProfileCandidateEvent.getExperiences() = _GetExperiencesEvent;
  const factory ProfileCandidateEvent.addExperiences(
      CandidateExperienceModels params) = _AddExperiencesEvent;
  const factory ProfileCandidateEvent.updateExperiences(
      CandidateExperienceModels params) = _UpdateExperiencesEvent;
  const factory ProfileCandidateEvent.deleteExperience(int id) =
      _DeleteExpEvent;
  const factory ProfileCandidateEvent.getEducation() = _GetEducationEvent;
  const factory ProfileCandidateEvent.addEducation(
      CandidateEducationModels params) = _AddEducationEvent;
  const factory ProfileCandidateEvent.updateEducation(
      CandidateEducationModels params) = _UpdateEducationEvent;
  const factory ProfileCandidateEvent.deleteEducation(int id) =
      _DeleteEducationEvent;
  const factory ProfileCandidateEvent.changePassword(
      ChangePasswordRequestParams params) = _ChangePasswordEvent;
  const factory ProfileCandidateEvent.updateProfile(
      ChangeProfileRequestParams params) = _UpdateProfileEvent;
  const factory ProfileCandidateEvent.getCVBuilder() = _GetCVBuilderEvent;
}
