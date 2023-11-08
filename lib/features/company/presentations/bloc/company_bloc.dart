import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/company/domain/usecases/add_favorite_company_usecase.dart';
import 'package:qatjobs/features/company/domain/usecases/get_company_usecase.dart';
import 'package:qatjobs/features/company/domain/usecases/get_favorite_company_usecase.dart';
import 'package:qatjobs/features/company/domain/usecases/report_company_usecase.dart';

part 'company_event.dart';
part 'company_state.dart';
part 'company_bloc.freezed.dart';

@injectable
class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final GetCompanyUseCase _getCompanyUseCase;
  final AddFavoriteCompanyUseCase _addFavoriteCompanyUseCase;
  final GetFavoriteCompanyUseCase _getFavoriteCompanyUseCase;
  final ReportCompanyUseCase _reportCompanyUseCase;
  CompanyBloc(
    this._getCompanyUseCase,
    this._addFavoriteCompanyUseCase,
    this._getFavoriteCompanyUseCase,
    this._reportCompanyUseCase,
  ) : super(CompanyState.initial()) {
    on<_Started>(
      (event, emit) async {
        emit(state.copyWith(status: CompanyStatus.loading));
        final result = await _getCompanyUseCase(event.params);
        if (event.params.name != null || event.isReset == true) {
         emit(state.copyWith(companies: []));
        }
        result.fold(
          (l) => emit(
            state.copyWith(
                status: CompanyStatus.failure, message: l.errorMessage),
          ),
          (r) => r.isEmpty
              ? emit(
                  state.copyWith(
                    hasMaxReached: true,
                    status: CompanyStatus.success,
                  ),
                )
              : emit(
                  state.copyWith(
                    status: CompanyStatus.success,
                    companies: [
                      ...state.companies,
                      ...r,
                    ],
                    currentPage: event.params.page ?? 1,
                  ),
                ),
        );
      },
    );
    on<_GetFavoriteCompany>(
      (event, emit) async {
        emit(state.copyWith(status: CompanyStatus.loading));
        final result = await _getFavoriteCompanyUseCase(NoParams());
        result.fold(
          (l) => emit(
            state.copyWith(
                status: CompanyStatus.failure, message: l.errorMessage),
          ),
          (r) => emit(
            state.copyWith(
              status: CompanyStatus.getFavoriteCompany,
              favoriteCompanies: r,
            ),
          ),
        );
      },
    );
    on<_AddFavoriteCompany>(
      (event, emit) async {
        emit(state.copyWith(status: CompanyStatus.loading));
        final result = await _addFavoriteCompanyUseCase(event.params);
        result.fold(
          (l) => emit(
            state.copyWith(
                status: CompanyStatus.failure, message: l.errorMessage),
          ),
          (r) => emit(
            state.copyWith(
              status: CompanyStatus.addFavoriteCompany,
              message: r
                  ? 'Follow Company successfully'
                  : 'Unfollow Company successfully',
            ),
          ),
        );
      },
    );
    on<_ReportCompany>((event, emit) async {
      emit(state.copyWith(status: CompanyStatus.loading));
      final result = await _reportCompanyUseCase(event.params);
      result.fold(
        (l) => emit(
          state.copyWith(
              status: CompanyStatus.failure, message: l.errorMessage),
        ),
        (r) => emit(
          state.copyWith(
              status: CompanyStatus.reportCompany,
              message: 'Report Company successfully'),
        ),
      );
    });
  }
}
