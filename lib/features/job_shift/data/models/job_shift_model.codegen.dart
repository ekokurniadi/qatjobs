import "package:freezed_annotation/freezed_annotation.dart";

part "job_shift_model.codegen.freezed.dart";
part "job_shift_model.codegen.g.dart";

@freezed
class JobShiftModel with _$JobShiftModel {
  factory JobShiftModel({
    required int id,
    required String shift,
    required String description,
    bool? isDefault,
  }) = _JobShiftModel;

  factory JobShiftModel.fromJson(Map<String, dynamic> json) =>
      _$JobShiftModelFromJson(json);
}
