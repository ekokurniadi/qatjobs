import "package:freezed_annotation/freezed_annotation.dart";

part "job_shift_entity.codegen.freezed.dart";

@freezed
class JobShiftEntity with _$JobShiftEntity {
  factory JobShiftEntity({
    required int id,
    required String shift,
    required String description,
    bool? isDefault,
  }) = _JobShiftEntity;
}
