import "package:freezed_annotation/freezed_annotation.dart";

part "active_featured_model.codegen.freezed.dart";
part "active_featured_model.codegen.g.dart";

@freezed
class ActiveFeaturedModel with _$ActiveFeaturedModel {
  factory ActiveFeaturedModel({
    int? id,
    int? ownerId,
    int? userId,
    String? stripeId,
    String? startTime,
    String? endTime,
  }) = _ActiveFeaturedModel;

  factory ActiveFeaturedModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveFeaturedModelFromJson(json);
}
