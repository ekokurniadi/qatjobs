import "package:freezed_annotation/freezed_annotation.dart";

part "city_model.codegen.freezed.dart";
part "city_model.codegen.g.dart";

@freezed
class CityModel with _$CityModel{

const factory CityModel({ 
	required int id,
	required int stateId,
	required String name,
})=_CityModel; 


factory CityModel.fromJson(Map<String,dynamic>json) => _$CityModelFromJson(json);

}
