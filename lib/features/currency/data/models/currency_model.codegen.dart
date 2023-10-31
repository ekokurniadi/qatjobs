import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/currency/domain/entities/currency_entity.codegen.dart";

part "currency_model.codegen.freezed.dart";
part "currency_model.codegen.g.dart";

@freezed
class CurrencyModel with _$CurrencyModel {
  const factory CurrencyModel({
    required int id,
    required String currencyName,
    required String currencyIcon,
    required String currencyCode,
  }) = _CurrencyModel;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);
}

extension CurrencyModelX on CurrencyModel {
  CurrencyEntity toDomain() => CurrencyEntity(
        id: id,
        currencyName: currencyName,
        currencyIcon: currencyIcon,
        currencyCode: currencyCode,
      );
}
