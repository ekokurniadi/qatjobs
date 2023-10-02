import 'package:freezed_annotation/freezed_annotation.dart';

part 'connectivity.codegen.freezed.dart';

@freezed
class InternetConnection with _$InternetConnection {
  const factory InternetConnection({
    required bool isConnected,
  }) = _InternetConnection;
}