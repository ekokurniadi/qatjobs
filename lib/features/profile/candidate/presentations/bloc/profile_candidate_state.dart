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
  getExperiences,
  addExperiences,
}

@freezed
class ProfileCandidateState with _$ProfileCandidateState {
  const factory ProfileCandidateState({
    required ProfileCandidateStatus status,
    required ProfileCandidateEntity generalProfile,
    required List<ResumeEntity> resumes,
    required List<CandidateExperienceEntity> experiences,
    required String message,
  }) = _ProfileCandidateState;

  factory ProfileCandidateState.initial() => ProfileCandidateState(
        status: ProfileCandidateStatus.initial,
        generalProfile: ProfileCandidateEntity(id: 0, userId: 0),
        resumes: [],
        message: '',
        experiences: [],
      );
}
