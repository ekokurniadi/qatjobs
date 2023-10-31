import "package:freezed_annotation/freezed_annotation.dart";

part "currency_entity.codegen.freezed.dart";

@freezed
class CurrencyEntity with _$CurrencyEntity {
  const factory CurrencyEntity({
    required int id,
    required String currencyName,
    required String currencyIcon,
    required String currencyCode,
  }) = _CurrencyEntity;

}
