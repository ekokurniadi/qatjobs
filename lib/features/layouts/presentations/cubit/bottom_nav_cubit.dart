import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'bottom_nav_state.dart';
part 'bottom_nav_cubit.freezed.dart';

@lazySingleton
class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavState.initial());

  FutureOr<void> setSelectedMenuIndex(int index) async {
    emit(state.copyWith(selectedMenuIndex: index));
  }
}
