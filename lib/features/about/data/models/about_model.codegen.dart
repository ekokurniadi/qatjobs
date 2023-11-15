import "package:freezed_annotation/freezed_annotation.dart";

part "about_model.codegen.freezed.dart";
part "about_model.codegen.g.dart";

@freezed
class AboutModel with _$AboutModel{

const factory AboutModel({ 
	required String id,
	required String title,
	required String description,
})=_AboutModel; 


factory AboutModel.fromJson(Map<String,dynamic>json) => _$AboutModelFromJson(json);

}
