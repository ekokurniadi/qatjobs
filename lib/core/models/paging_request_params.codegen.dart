import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging_request_params.codegen.freezed.dart';
part 'paging_request_params.codegen.g.dart';

@freezed
class PagingRequestParams with _$PagingRequestParams {
  @JsonSerializable(includeIfNull: false)
   factory PagingRequestParams({
    @Default(10) @JsonKey(name: 'perPage') int? perPage,
    @Default(1) int? page,
    int? id,
  }) = _PagingRequestParams;

  factory PagingRequestParams.fromJson(Map<String, dynamic> json) =>
      _$PagingRequestParamsFromJson(json);
}
