part of 'theme_cubit.dart';

class SwitchState {
  final bool isDarkThemeOn;
  late ThemeData theme;
  SwitchState({required this.isDarkThemeOn}) {
    if (isDarkThemeOn) {
      theme = appThemeData[AppTheme.darkTheme]!;
    } else {
      theme = appThemeData[AppTheme.lightTheme]!;
    }
  }

  SwitchState copyWith({required bool changeState}) {
    return SwitchState(isDarkThemeOn: changeState);
  }
}
