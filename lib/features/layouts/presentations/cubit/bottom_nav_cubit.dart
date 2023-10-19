import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';
import 'package:qatjobs/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bottom_nav_state.dart';
part 'bottom_nav_cubit.freezed.dart';

@lazySingleton
class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavState.initial());

  FutureOr<void> setSelectedMenuIndex(int index) async {
    if (index == 0) {
      UserModel? userModel;

      final getUser = getIt<SharedPreferences>().getString(
        AppConstant.prefKeyUserLogin,
      );
      if (!GlobalHelper.isEmpty(getUser)) {
        userModel = UserModel.fromJson(
          jsonDecode(getUser!),
        );
        emit(state.copyWith(
          selectedMenuIndex: index,
          user: userModel,
        ));
      } else {
        emit(state.copyWith(selectedMenuIndex: index));
      }
    } else {
      emit(state.copyWith(selectedMenuIndex: index));
    }
  }
}
