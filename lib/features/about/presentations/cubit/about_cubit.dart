import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/about/data/models/about_model.codegen.dart';
import 'package:qatjobs/features/about/domain/usecases/get_job_alert_usecase.dart';

part 'about_state.dart';
part 'about_cubit.freezed.dart';

@injectable
class AboutCubit extends Cubit<AboutState> {
  final GetAboutUseCase _aboutUseCase;
  AboutCubit(
    this._aboutUseCase,
  ) : super(AboutState.initial());

  Future<void> getAbout() async {
    emit(state.copyWith(status: AboutStatus.loading));
    final result = await _aboutUseCase(NoParams());

    result.fold(
      (l) => emit(
        state.copyWith(
          status: AboutStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: AboutStatus.failure,
          abouts: r,
        ),
      ),
    );
  }
}
