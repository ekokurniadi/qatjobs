import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/active_featured/domain/entities/active_featured_entity.codegen.dart";
import "package:qatjobs/features/company/domain/entities/company_entity.codegen.dart";
import "package:qatjobs/features/job_category/domain/entities/job_category_entity.codegen.dart";
import "package:qatjobs/features/job_shift/domain/entities/job_shift_entity.codegen.dart";
import "package:qatjobs/features/jobs_skill/domain/entities/jobs_skill_entity.codegen.dart";

part "job_entity.codegen.freezed.dart";

@freezed
class JobEntity with _$JobEntity {
  factory JobEntity({
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
    JobShiftEntity? jobShift,
    int? degreeLevelId,
    int? position,
    String? jobExpiryDate,
    int? noPreference,
    bool? hideSalary,
    bool? isFreelance,
    bool? isSuspended,
    int? status,
    String? submissionStatusId,
    String? createdAt,
    String? updatedAt,
    int? experience,
    String? isDefault,
    int? isCreatedByAdmin,
    ActiveFeaturedEntity? activeFeatured,
    CompanyEntity? company,
    JobsSkillEntity? jobsSkill,
    JobCategoryEntity? jobCategory,
  }) = _JobEntity;
}
