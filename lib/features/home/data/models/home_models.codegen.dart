import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/article/data/models/article_model.codegen.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';
import 'package:qatjobs/features/job_category/data/models/job_category_model.codegen.dart';
import 'package:qatjobs/features/plan/data/models/plan_model.codegen.dart';

part "home_models.codegen.freezed.dart";
part "home_models.codegen.g.dart";

@freezed
class HomeModels with _$HomeModels {
  factory HomeModels({
    @JsonKey(name: 'dataCounts') required DataCountsModel dataCounts,
    @JsonKey(name: 'latestJobs') required List<JobModel> latestJobs,
    @JsonKey(name: 'jobCategories')
    required Map<String, JobCategoryModel> jobCategories,
    @JsonKey(name: 'allCompanies') required List<CompanyModel> allCompanies,
    required Map<String, PlanModel> plans,
    @JsonKey(name: 'recentBlog') required List<ArticleModel> recentBlog,
  }) = _HomeModels;

  factory HomeModels.fromJson(Map<String, dynamic> json) =>
      _$HomeModelsFromJson(json);
}

@freezed
class DataCountsModel with _$DataCountsModel {
  factory DataCountsModel({
    required int candidates,
    required int jobs,
    required int resumes,
    required int companies,
  }) = _DataCountsModel;

  factory DataCountsModel.fromJson(Map<String, dynamic> json) =>
      _$DataCountsModelFromJson(json);
}
