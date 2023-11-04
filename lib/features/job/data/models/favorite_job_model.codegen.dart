import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';

part "favorite_job_model.codegen.freezed.dart";
part "favorite_job_model.codegen.g.dart";

@freezed
class FavoriteJobModel with _$FavoriteJobModel {
  factory FavoriteJobModel({
    required int id,
    required JobModel job,
  }) = _FavoriteJobModel;

  factory FavoriteJobModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteJobModelFromJson(json);
}
