import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/active_featured/data/models/active_featured_model.codegen.dart";
import "package:qatjobs/features/carrier_level/data/models/career_level_model.codegen.dart";
import "package:qatjobs/features/company/data/models/company_model.codegen.dart";
import "package:qatjobs/features/currency/data/models/currency_model.codegen.dart";
import "package:qatjobs/features/degree_level/data/models/degree_level_model.codegen.dart";
import "package:qatjobs/features/functional_area/data/models/functional_area_model.codegen.dart";
import "package:qatjobs/features/job/data/models/applied_job_model.codegen.dart";
import "package:qatjobs/features/job_category/data/models/job_category_model.codegen.dart";
import "package:qatjobs/features/job_shift/data/models/job_shift_model.codegen.dart";
import "package:qatjobs/features/job_tags/data/models/job_tags_model.codegen.dart";
import "package:qatjobs/features/jobs_skill/data/models/jobs_skill_model.codegen.dart";
import "package:qatjobs/features/salary_period/data/models/salary_period_model.codegen.dart";

import "../../../submission_status/data/models/submission_status_model.codegen.dart";

part "job_model.codegen.freezed.dart";
part "job_model.codegen.g.dart";

@freezed
class JobModel with _$JobModel {
  factory JobModel({
    int? id,
    String? jobId,
    String? jobTitle,
    String? description,
    int? salaryFrom,
    int? salaryTo,
    int? companyId,
    int? jobCategoryId,
    int? currencyId,
    int? salaryPeriodId,
    int? jobTypeId,
    int? careerLevelId,
    int? functionalAreaId,
    int? jobShiftId,
    JobShiftModel? jobShift,
    int? degreeLevelId,
    int? position,
    String? jobExpiryDate,
    int? noPreference,
    bool? hideSalary,
    bool? isFreelance,
    bool? isSuspended,
    int? status,
    dynamic submissionStatusId,
    String? createdAt,
    String? updatedAt,
    int? experience,
    int? isCreatedByAdmin,
    ActiveFeaturedModel? activeFeatured,
    CompanyModel? company,
    List<JobsSkillModel>? jobsSkill,
    JobCategoryModel? jobCategory,
    CurrencyModel? currency,
    List<JobsTag>? jobsTag,
    SalaryPeriod? salaryPeriod,
    SubmissionStatus? submissionStatus,
    DegreeLevelModel? degreeLevel,
    CareerLevelModel? careerLevel,
    FunctionalAreaModel? functionalArea,
    dynamic totalAppliedJobs,
    List<AppliedJobModel>? appliedJobs,
  }) = _JobModel;

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);
}
