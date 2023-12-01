part of 'profile_candidate_bloc.dart';

enum ProfileCandidateStatus {
  initial,
  loading,
  failure,
  getGeneralProfile,
  generalProfileSaved,
  getResume,
  insertResume,
  downloadResume,
  deleteResume,
  deleteExperience,
  getExperiences,
  addExperiences,
  updateExperiences,
  deleteEducation,
  getEducation,
  addEducation,
  updateEducation,
  changePasswordSuccess,
  updateProfileSuccess,
  getCvBuilder,
}

@freezed
class ProfileCandidateState with _$ProfileCandidateState {
  const factory ProfileCandidateState({
    required ProfileCandidateStatus status,
    required ProfileCandidateEntity generalProfile,
    required List<ResumeEntity> resumes,
    required List<CandidateExperienceEntity> experiences,
    required List<CandidateEducationEntity> educations,
    required String message,
    required Option<Either<Failures, CvBuilderResponseModels>> cvBuilder,
    required bool isProfileComplete,
  }) = _ProfileCandidateState;

  factory ProfileCandidateState.initial() => ProfileCandidateState(
        status: ProfileCandidateStatus.initial,
        generalProfile: ProfileCandidateEntity(id: 0, userId: 0),
        resumes: [],
        message: '',
        experiences: [],
        educations: [],
        cvBuilder: none(),
        isProfileComplete: false,
      );
}
