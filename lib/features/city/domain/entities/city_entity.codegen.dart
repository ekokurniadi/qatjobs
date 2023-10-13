import "package:freezed_annotation/freezed_annotation.dart";

part "city_entity.codegen.freezed.dart";
part "city_entity.codegen.g.dart";

@freezed
class CityEntity with _$CityEntity{

const factory CityEntity({ 
	required int id,
	required int stateId,
	required String name,
})=_CityEntity; 


factory CityEntity.fromJson(Map<String,dynamic>json) => _$CityEntityFromJson(json);

}
