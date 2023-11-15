part of 'about_cubit.dart';

enum AboutStatus { initial, loading, complete, failure }

@freezed
class AboutState with _$AboutState {
  const factory AboutState({
    required AboutStatus status,
    required List<AboutModel> abouts,
    required String message,
  }) = _AboutState;

  factory AboutState.initial() =>
      const AboutState(abouts: [], status: AboutStatus.initial, message: '');
}
