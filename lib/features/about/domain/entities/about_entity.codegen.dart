import "package:freezed_annotation/freezed_annotation.dart";

part "about_entity.codegen.freezed.dart";
part "about_entity.codegen.g.dart";

@freezed
class AboutEntity with _$AboutEntity{

const factory AboutEntity({ 
	required String id,
	required String title,
	required String description,
})=_AboutEntity; 


factory AboutEntity.fromJson(Map<String,dynamic>json) => _$AboutEntityFromJson(json);

}
