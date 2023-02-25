import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../ui/theme_data/themes.dart';

part 'theme_state.dart';

class SwitchCubit extends Cubit<SwitchState> {
  SwitchCubit() : super(SwitchState(isDarkThemeOn: true));

  void toggleSwitch(bool value) => emit(state.copyWith(changeState: value));
}
