import "package:freezed_annotation/freezed_annotation.dart";

part "active_featured_entity.codegen.freezed.dart";

@freezed
class ActiveFeaturedEntity with _$ActiveFeaturedEntity {
  factory ActiveFeaturedEntity({
    int? id,
    int? ownerId,
    int? userId,
    String? stripeId,
    String? startTime,
    String? endTime,
  }) = _ActiveFeaturedEntity;
}
