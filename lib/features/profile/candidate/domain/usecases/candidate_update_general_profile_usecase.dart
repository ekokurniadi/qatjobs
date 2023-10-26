import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/profile/candidate/domain/repositories/candidate_profile_repository.dart';

@injectable
class CandidateUpdateGeneralProfile
    implements UseCase<bool, GeneralProfileRequestParams> {
  final CandidateProfileRepository _repository;

  const CandidateUpdateGeneralProfile(this._repository);

  @override
  Future<Either<Failures, bool>> call(
    GeneralProfileRequestParams params,
  ) async {
   return await _repository.updateGeneralProfile(params);
  }
}

// ignore: must_be_immutable
class GeneralProfileRequestParams extends Equatable {
  final String firstName;
  final String lastName;
  List<int>? candidateSkill;
  String? phone;
  String? facebookUrl;
  String? twitterUrl;
  String? linkedinUrl;
  String? googlePlusUrl;
  String? pinterestUrl;
  int? maritalStatusId;
  int? experience;
  int? careerLevelId;
  int? industryId;
  int? functionalAreaId;
  double? currentSalary;
  double? expectedSalary;
  int? immediateAvailable;
  String? availableAt;
  String? address;
  int? gender;
  String? fatherName;
  String? dob;

  GeneralProfileRequestParams({
    required this.firstName,
    required this.lastName,
    this.address,
    this.availableAt,
    this.candidateSkill,
    this.careerLevelId,
    this.currentSalary,
    this.dob,
    this.expectedSalary,
    this.experience,
    this.facebookUrl,
    this.fatherName,
    this.functionalAreaId,
    this.gender,
    this.googlePlusUrl,
    this.immediateAvailable,
    this.industryId,
    this.linkedinUrl,
    this.maritalStatusId,
    this.phone,
    this.pinterestUrl,
    this.twitterUrl,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
    };

    if (candidateSkill != null) {
      data['candidateSkills'] = candidateSkill;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    if (facebookUrl != null) {
      data['facebook_url'] = facebookUrl;
    }
    if (twitterUrl != null) {
      data['twitter_url'] = twitterUrl;
    }
    if (linkedinUrl != null) {
      data['linkedin_url'] = linkedinUrl;
    }
    if (googlePlusUrl != null) {
      data['google_plus_url'] = googlePlusUrl;
    }
    if (pinterestUrl != null) {
      data['pinterest_url'] = pinterestUrl;
    }
    if (maritalStatusId != null) {
      data['marital_status_id'] = maritalStatusId;
    }
    if (experience != null) {
      data['experience'] = experience;
    }
    if (careerLevelId != null) {
      data['career_level_id'] = careerLevelId;
    }
    if (industryId != null) {
      data['industry_id'] = industryId;
    }
    if (functionalAreaId != null) {
      data['functional_area_id'] = functionalAreaId;
    }
    if (currentSalary != null) {
      data['current_salary'] = currentSalary;
    }
    if (expectedSalary != null) {
      data['expected_salary'] = expectedSalary;
    }
    if (immediateAvailable != null) {
      data['immediate_available'] = immediateAvailable;
    }
    if (availableAt != null) {
      data['available_at'] = availableAt;
    }
    if (address != null) {
      data['address'] = address;
    }
    if (gender != null) {
      data['gender'] = gender;
    }
    if (fatherName != null) {
      data['father_name'] = fatherName;
    }
    if (dob != null) {
      data['dob'] = dob;
    }

    return data;
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        candidateSkill,
        phone,
        facebookUrl,
        twitterUrl,
        linkedinUrl,
        googlePlusUrl,
        pinterestUrl,
        maritalStatusId,
        experience,
        careerLevelId,
        industryId,
        functionalAreaId,
        currentSalary,
        expectedSalary,
        immediateAvailable,
        availableAt,
        address,
        gender,
        fatherName,
        dob,
      ];
}
