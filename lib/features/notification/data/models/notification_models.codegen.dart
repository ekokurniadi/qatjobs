import "package:freezed_annotation/freezed_annotation.dart";

part "notification_models.codegen.freezed.dart";
part "notification_models.codegen.g.dart";

@freezed
class NotificationModel with _$NotificationModel {
  factory NotificationModel({
    required int id,
    required int type,
    required int notificationFor,
    required int userId,
    required String title,
    String? text,
    String? readAt,
    String? createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
