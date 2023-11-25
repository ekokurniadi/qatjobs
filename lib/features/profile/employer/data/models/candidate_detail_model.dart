// To parse this JSON data, do
//
//     final candidateDetail = candidateDetailFromJson(jsonString);

import 'dart:convert';

CandidateDetail candidateDetailFromJson(String str) =>
    CandidateDetail.fromJson(json.decode(str));

String candidateDetailToJson(CandidateDetail data) =>
    json.encode(data.toJson());

class CandidateDetail {
  final bool? isReportedToCandidate;
  final CandidateDetails? candidateDetails;
  final List<CandidateExperience>? candidateExperiences;
  final List<CandidateEducation>? candidateEducations;

  CandidateDetail({
    this.isReportedToCandidate,
    this.candidateDetails,
    this.candidateExperiences,
    this.candidateEducations,
  });

  factory CandidateDetail.fromJson(Map<String, dynamic> json) =>
      CandidateDetail(
        isReportedToCandidate: json["isReportedToCandidate"],
        candidateDetails: json["candidateDetails"] == null
            ? null
            : CandidateDetails.fromJson(json["candidateDetails"]),
        candidateExperiences: json["candidateExperiences"] == null
            ? []
            : List<CandidateExperience>.from(json["candidateExperiences"]!
                .map((x) => CandidateExperience.fromJson(x))),
        candidateEducations: json["candidateEducations"] == null
            ? []
            : List<CandidateEducation>.from(json["candidateEducations"]!
                .map((x) => CandidateEducation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isReportedToCandidate": isReportedToCandidate,
        "candidateDetails": candidateDetails?.toJson(),
        "candidateExperiences": candidateExperiences == null
            ? []
            : List<dynamic>.from(candidateExperiences!.map((x) => x.toJson())),
        "candidateEducations": candidateEducations == null
            ? []
            : List<dynamic>.from(candidateEducations!.map((x) => x.toJson())),
      };
}

class CandidateDetails {
  final int? id;
  final int? userId;
  final String? uniqueId;
  final String? fatherName;
  final int? maritalStatusId;
  final String? nationality;
  final String? nationalIdCard;
  final int? experience;
  final int? careerLevelId;
  final int? industryId;
  final int? functionalAreaId;
  final double? currentSalary;
  final int? expectedSalary;
  final String? salaryCurrency;
  final String? address;
  final bool? immediateAvailable;
  final String? availableAt;
  final String? createdAt;
  final String? updatedAt;
  final String? jobAlert;
  final dynamic lastChange;
  final dynamic countryName;
  final dynamic stateName;
  final dynamic cityName;
  final dynamic fullLocation;
  final String? candidateUrl;
  final User? user;
  final List<dynamic>? jobApplications;
  final CareerLevel? industry;
  final CareerLevel? maritalStatus;
  final CareerLevel? careerLevel;
  final CareerLevel? functionalArea;

  CandidateDetails({
    this.id,
    this.userId,
    this.uniqueId,
    this.fatherName,
    this.maritalStatusId,
    this.nationality,
    this.nationalIdCard,
    this.experience,
    this.careerLevelId,
    this.industryId,
    this.functionalAreaId,
    this.currentSalary,
    this.expectedSalary,
    this.salaryCurrency,
    this.address,
    this.immediateAvailable,
    this.availableAt,
    this.createdAt,
    this.updatedAt,
    this.jobAlert,
    this.lastChange,
    this.countryName,
    this.stateName,
    this.cityName,
    this.fullLocation,
    this.candidateUrl,
    this.user,
    this.jobApplications,
    this.industry,
    this.maritalStatus,
    this.careerLevel,
    this.functionalArea,
  });

  factory CandidateDetails.fromJson(Map<String, dynamic> json) =>
      CandidateDetails(
        id: json["id"],
        userId: json["user_id"],
        uniqueId: json["unique_id"],
        fatherName: json["father_name"],
        maritalStatusId: json["marital_status_id"],
        nationality: json["nationality"],
        nationalIdCard: json["national_id_card"],
        experience: json["experience"],
        careerLevelId: json["career_level_id"],
        industryId: json["industry_id"],
        functionalAreaId: json["functional_area_id"],
        currentSalary: json["current_salary"]?.toDouble(),
        expectedSalary: json["expected_salary"],
        salaryCurrency: json["salary_currency"],
        address: json["address"],
        immediateAvailable: json["immediate_available"],
        availableAt: json["available_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        jobAlert: json["job_alert"],
        lastChange: json["last_change"],
        countryName: json["country_name"],
        stateName: json["state_name"],
        cityName: json["city_name"],
        fullLocation: json["full_location"],
        candidateUrl: json["candidate_url"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        jobApplications: json["job_applications"] == null
            ? []
            : List<dynamic>.from(json["job_applications"]!.map((x) => x)),
        industry: json["industry"] == null
            ? null
            : CareerLevel.fromJson(json["industry"]),
        maritalStatus: json["marital_status"] == null
            ? null
            : CareerLevel.fromJson(json["marital_status"]),
        careerLevel: json["career_level"] == null
            ? null
            : CareerLevel.fromJson(json["career_level"]),
        functionalArea: json["functional_area"] == null
            ? null
            : CareerLevel.fromJson(json["functional_area"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "unique_id": uniqueId,
        "father_name": fatherName,
        "marital_status_id": maritalStatusId,
        "nationality": nationality,
        "national_id_card": nationalIdCard,
        "experience": experience,
        "career_level_id": careerLevelId,
        "industry_id": industryId,
        "functional_area_id": functionalAreaId,
        "current_salary": currentSalary,
        "expected_salary": expectedSalary,
        "salary_currency": salaryCurrency,
        "address": address,
        "immediate_available": immediateAvailable,
        "available_at": availableAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "job_alert": jobAlert,
        "last_change": lastChange,
        "country_name": countryName,
        "state_name": stateName,
        "city_name": cityName,
        "full_location": fullLocation,
        "candidate_url": candidateUrl,
        "user": user?.toJson(),
        "job_applications": jobApplications == null
            ? []
            : List<dynamic>.from(jobApplications!.map((x) => x)),
        "industry": industry?.toJson(),
        "marital_status": maritalStatus?.toJson(),
        "career_level": careerLevel?.toJson(),
        "functional_area": functionalArea?.toJson(),
      };
}

class CareerLevel {
  final int? id;
  final String? levelName;
  final String? createdAt;
  final String? updatedAt;
  final bool? isDefault;
  final String? name;
  final String? description;
  final String? maritalStatus;
  final Pivot? pivot;

  CareerLevel({
    this.id,
    this.levelName,
    this.createdAt,
    this.updatedAt,
    this.isDefault,
    this.name,
    this.description,
    this.maritalStatus,
    this.pivot,
  });

  factory CareerLevel.fromJson(Map<String, dynamic> json) => CareerLevel(
        id: json["id"],
        levelName: json["level_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isDefault: json["is_default"],
        name: json["name"],
        description: json["description"],
        maritalStatus: json["marital_status"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level_name": levelName,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_default": isDefault,
        "name": name,
        "description": description,
        "marital_status": maritalStatus,
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  final String? userId;
  final String? skillId;

  Pivot({
    this.userId,
    this.skillId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        skillId: json["skill_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "skill_id": skillId,
      };
}

class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final dynamic emailVerifiedAt;
  final dynamic dob;
  final int? gender;
  final dynamic countryId;
  final dynamic stateId;
  final dynamic cityId;
  final bool? isActive;
  final bool? isVerified;
  final int? ownerId;
  final String? ownerType;
  final String? language;
  final int? profileViews;
  final String? themeMode;
  final String? createdAt;
  final String? updatedAt;
  final dynamic facebookUrl;
  final dynamic twitterUrl;
  final dynamic linkedinUrl;
  final dynamic googlePlusUrl;
  final dynamic pinterestUrl;
  final bool? isDefault;
  final dynamic stripeId;
  final String? regionCode;
  final String? fullName;
  final String? avatar;
  final dynamic countryName;
  final dynamic stateName;
  final dynamic cityName;
  final List<dynamic>? media;
  final dynamic country;
  final dynamic city;
  final dynamic state;
  final List<CareerLevel>? candidateSkill;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.dob,
    this.gender,
    this.countryId,
    this.stateId,
    this.cityId,
    this.isActive,
    this.isVerified,
    this.ownerId,
    this.ownerType,
    this.language,
    this.profileViews,
    this.themeMode,
    this.createdAt,
    this.updatedAt,
    this.facebookUrl,
    this.twitterUrl,
    this.linkedinUrl,
    this.googlePlusUrl,
    this.pinterestUrl,
    this.isDefault,
    this.stripeId,
    this.regionCode,
    this.fullName,
    this.avatar,
    this.countryName,
    this.stateName,
    this.cityName,
    this.media,
    this.country,
    this.city,
    this.state,
    this.candidateSkill,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"],
        dob: json["dob"],
        gender: json["gender"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        isActive: json["is_active"],
        isVerified: json["is_verified"],
        ownerId: json["owner_id"],
        ownerType: json["owner_type"],
        language: json["language"],
        profileViews: json["profile_views"],
        themeMode: json["theme_mode"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        facebookUrl: json["facebook_url"],
        twitterUrl: json["twitter_url"],
        linkedinUrl: json["linkedin_url"],
        googlePlusUrl: json["google_plus_url"],
        pinterestUrl: json["pinterest_url"],
        isDefault: json["is_default"],
        stripeId: json["stripe_id"],
        regionCode: json["region_code"],
        fullName: json["full_name"],
        avatar: json["avatar"],
        countryName: json["country_name"],
        stateName: json["state_name"],
        cityName: json["city_name"],
        media: json["media"] == null
            ? []
            : List<dynamic>.from(json["media"]!.map((x) => x)),
        country: json["country"],
        city: json["city"],
        state: json["state"],
        candidateSkill: json["candidate_skill"] == null
            ? []
            : List<CareerLevel>.from(
                json["candidate_skill"]!.map((x) => CareerLevel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "email_verified_at": emailVerifiedAt,
        "dob": dob,
        "gender": gender,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "is_active": isActive,
        "is_verified": isVerified,
        "owner_id": ownerId,
        "owner_type": ownerType,
        "language": language,
        "profile_views": profileViews,
        "theme_mode": themeMode,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "facebook_url": facebookUrl,
        "twitter_url": twitterUrl,
        "linkedin_url": linkedinUrl,
        "google_plus_url": googlePlusUrl,
        "pinterest_url": pinterestUrl,
        "is_default": isDefault,
        "stripe_id": stripeId,
        "region_code": regionCode,
        "full_name": fullName,
        "avatar": avatar,
        "country_name": countryName,
        "state_name": stateName,
        "city_name": cityName,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
        "country": country,
        "city": city,
        "state": state,
        "candidate_skill": candidateSkill == null
            ? []
            : List<dynamic>.from(candidateSkill!.map((x) => x.toJson())),
      };
}

class CandidateEducation {
  final int? id;
  final int? candidateId;
  final int? degreeLevelId;
  final String? degreeTitle;
  final dynamic countryId;
  final dynamic stateId;
  final dynamic cityId;
  final String? institute;
  final String? result;
  final int? year;
  final String? createdAt;
  final String? updatedAt;
  final dynamic countryName;
  final CareerLevel? degreeLevel;

  CandidateEducation({
    this.id,
    this.candidateId,
    this.degreeLevelId,
    this.degreeTitle,
    this.countryId,
    this.stateId,
    this.cityId,
    this.institute,
    this.result,
    this.year,
    this.createdAt,
    this.updatedAt,
    this.countryName,
    this.degreeLevel,
  });

  factory CandidateEducation.fromJson(Map<String, dynamic> json) =>
      CandidateEducation(
        id: json["id"],
        candidateId: json["candidate_id"],
        degreeLevelId: json["degree_level_id"],
        degreeTitle: json["degree_title"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        institute: json["institute"],
        result: json["result"],
        year: json["year"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        countryName: json["country_name"],
        degreeLevel: json["degree_level"] == null
            ? null
            : CareerLevel.fromJson(json["degree_level"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "candidate_id": candidateId,
        "degree_level_id": degreeLevelId,
        "degree_title": degreeTitle,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "institute": institute,
        "result": result,
        "year": year,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "country_name": countryName,
        "degree_level": degreeLevel?.toJson(),
      };
}

class CandidateExperience {
  final int? id;
  final int? candidateId;
  final String? experienceTitle;
  final String? company;
  final dynamic countryId;
  final dynamic stateId;
  final dynamic cityId;
  final String? startDate;
  final String? endDate;
  final bool? currentlyWorking;
  final dynamic description;
  final String? createdAt;
  final String? updatedAt;
  final dynamic countryName;

  CandidateExperience({
    this.id,
    this.candidateId,
    this.experienceTitle,
    this.company,
    this.countryId,
    this.stateId,
    this.cityId,
    this.startDate,
    this.endDate,
    this.currentlyWorking,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.countryName,
  });

  factory CandidateExperience.fromJson(Map<String, dynamic> json) =>
      CandidateExperience(
        id: json["id"],
        candidateId: json["candidate_id"],
        experienceTitle: json["experience_title"],
        company: json["company"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        currentlyWorking: json["currently_working"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        countryName: json["country_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "candidate_id": candidateId,
        "experience_title": experienceTitle,
        "company": company,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "start_date": startDate,
        "end_date": endDate,
        "currently_working": currentlyWorking,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "country_name": countryName,
      };
}
