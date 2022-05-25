import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class _AppColors {
  static const Color appTransparent = Colors.transparent;
  static const Color appWhite = Color(0xffffffff);
  static const Color appBlack = Color(0xff000000);
  static const Color appPrimary = Color(0xffEB9404);
  static const Color appError = Color(0xffFF7D88);
  static const Color appTertiary = Color(0xffF3F5ED);

  static const Color appTrack = Color(0xff37A693);

  static const Color appButtonDisabled = Color(0x88eb9404);

  static const Color appButtonGradientLeft = Color(0xffAE21E3);
  static const Color appButtonGradientRight = Color(0xff7800ED);

  static const Color lightModeBackgroundGradientTop = Color(0xffF4F4F4);
  static const Color lightModeBackgroundGradientBottom = Color(0xffE6E6E6);
  static const Color darkModeBackgroundGradientTop = Color(0xff262626);
  static const Color darkModeBackgroundGradientBottom = Color(0xff646464);
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance?.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  ThemeData buildLightTheme() {
    return ThemeData(
        fontFamily: 'museo_sans_ssv',
        appBarTheme: _lightAppBarTheme,
        brightness: Brightness.light,
        buttonTheme: _buttonTheme,
        colorScheme: _lightColorScheme,
        canvasColor: _AppColors.appWhite,
        cardTheme: const CardTheme(color: _AppColors.appWhite),
        checkboxTheme: _checkboxTheme,
        primaryColor: _AppColors.appWhite,
        secondaryHeaderColor: Colors.transparent,
        scaffoldBackgroundColor: _AppColors.appWhite,
        cardColor: _AppColors.appWhite,
        elevatedButtonTheme: _elevatedButtonTheme,
        errorColor: _AppColors.appError,
        floatingActionButtonTheme: _floatingActionButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        radioTheme: _radioTheme,
        sliderTheme: _sliderTheme,
        switchTheme: _switchThemeData,
        textButtonTheme: _textButtonTheme,
        textTheme: Typography().englishLike);
  }

  ThemeData buildDarkTheme() {
    return ThemeData(
        fontFamily: 'museo_sans_ssv',
        appBarTheme: _darkAppBarTheme,
        brightness: Brightness.dark,
        buttonTheme: _buttonTheme,
        colorScheme: _darkColorScheme,
        canvasColor: _AppColors.appBlack,
        cardTheme: const CardTheme(color: _AppColors.appBlack),
        checkboxTheme: _checkboxTheme,
        primaryColor: _AppColors.appBlack,
        secondaryHeaderColor: _AppColors.appWhite,
        scaffoldBackgroundColor: Colors.transparent,
        cardColor: _AppColors.appBlack,
        elevatedButtonTheme: _elevatedButtonTheme,
        errorColor: _AppColors.appError,
        floatingActionButtonTheme: _floatingActionButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        radioTheme: _radioTheme,
        sliderTheme: _sliderTheme,
        switchTheme: _switchThemeData,
        textButtonTheme: _textButtonTheme,
        textTheme: Typography().englishLike);
  }
}

const ColorScheme _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  background: _AppColors.appWhite,
  error: _AppColors.appError,
  inversePrimary: _AppColors.appBlack,
  onPrimary: _AppColors.appButtonGradientLeft,
  onPrimaryContainer: _AppColors.lightModeBackgroundGradientTop,
  onSecondary: _AppColors.appButtonGradientRight,
  onSecondaryContainer: _AppColors.appTrack,
  onSurface: _AppColors.appBlack,
  onBackground: _AppColors.appBlack,
  onError: _AppColors.appButtonDisabled,
  primary: _AppColors.appPrimary,
  tertiary: _AppColors.appTertiary,
  secondary: _AppColors.appWhite,
  surface: _AppColors.appBlack,
);

const ColorScheme _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  background: _AppColors.appBlack,
  error: _AppColors.appError,
  inversePrimary: _AppColors.appWhite,
  onPrimary: _AppColors.appButtonGradientLeft,
  onPrimaryContainer: _AppColors.darkModeBackgroundGradientTop,
  onSecondary: _AppColors.appButtonGradientRight,
  onSecondaryContainer: _AppColors.darkModeBackgroundGradientBottom,
  onSurface: _AppColors.appBlack,
  onBackground: _AppColors.appBlack,
  onError: _AppColors.appButtonDisabled,
  primary: _AppColors.appPrimary,
  tertiary: _AppColors.appPrimary,
  secondary: _AppColors.appBlack,
  surface: _AppColors.appBlack,
);

AppBarTheme _lightAppBarTheme = const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: _AppColors.appBlack),
    titleTextStyle: TextStyle(color: _AppColors.appBlack, fontSize: 20),
    toolbarTextStyle: TextStyle(color: _AppColors.appBlack, fontSize: 14),
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    foregroundColor: _AppColors.appBlack,
    iconTheme: IconThemeData(color: _AppColors.appBlack),
    actionsIconTheme: IconThemeData(color: _AppColors.appBlack));

AppBarTheme _darkAppBarTheme = const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    titleTextStyle: TextStyle(color: _AppColors.appWhite, fontSize: 20),
    toolbarTextStyle: TextStyle(color: _AppColors.appWhite, fontSize: 14),
    backgroundColor: Colors.transparent,
    shadowColor: _AppColors.darkModeBackgroundGradientTop,
    elevation: 0,
    foregroundColor: _AppColors.appWhite,
    actionsIconTheme: IconThemeData(color: _AppColors.appWhite));

const ButtonThemeData _buttonTheme = ButtonThemeData(
  alignedDropdown: false,
  height: 36,
);

final CheckboxThemeData _checkboxTheme =
    CheckboxThemeData(fillColor: MaterialStateProperty.resolveWith(getCheckboxColor));

final RadioThemeData _radioTheme = RadioThemeData(fillColor: MaterialStateProperty.resolveWith(getRadioColor));

const SliderThemeData _sliderTheme = SliderThemeData(
    activeTrackColor: _AppColors.appPrimary,
    thumbColor: _AppColors.appPrimary,
    inactiveTrackColor: _AppColors.appTrack);

final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
  backgroundColor: MaterialStateProperty.resolveWith(getElevatedButtonColor),
  foregroundColor: MaterialStateProperty.resolveWith(getButtonTextColor),
));

const FloatingActionButtonThemeData _floatingActionButtonTheme = FloatingActionButtonThemeData(
  backgroundColor: _AppColors.appPrimary,
  foregroundColor: _AppColors.appWhite,
);

final OutlinedButtonThemeData _outlinedButtonTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
  foregroundColor: MaterialStateProperty.resolveWith(getButtonTextColor),
  side: MaterialStateProperty.resolveWith(getBorderColor),
));

final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
  foregroundColor: MaterialStateProperty.resolveWith(getButtonColor),
));

final SwitchThemeData _switchThemeData = SwitchThemeData(
  overlayColor: MaterialStateProperty.resolveWith(getOverlayColor),
  thumbColor: MaterialStateProperty.resolveWith(getThumbColor),
  trackColor: MaterialStateProperty.resolveWith(getTrackColor),
);

Color getCheckboxColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  if (states.any(interactiveStates.contains)) {
    return _AppColors.appPrimary;
  }

  return _AppColors.appPrimary;
}

Color getElevatedButtonColor(Set<MaterialState> states) {
  return _AppColors.appTransparent;
}

Color getButtonTextColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.disabled,
  };

  if (interactiveStates.any(states.contains)) {
    return _AppColors.appButtonDisabled;
  }

  return _AppColors.appWhite;
}

Color getButtonColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.disabled,
  };

  if (interactiveStates.any(states.contains)) {
    return _AppColors.appButtonDisabled;
  }

  return _AppColors.appWhite;
}

BorderSide getBorderColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.disabled,
  };

  if (interactiveStates.any(states.contains)) {
    return const BorderSide(color: _AppColors.appButtonDisabled);
  }

  return const BorderSide(color: _AppColors.appWhite);
}

Color getRadioColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.disabled,
  };

  if (states.any(interactiveStates.contains)) {
    return _AppColors.appButtonDisabled;
  }

  return _AppColors.appPrimary;
}

Color getOverlayColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
  };

  if (states.any(interactiveStates.contains)) {
    return const Color(0x1f7800ed);
  }

  return _AppColors.appPrimary;
}

Color getThumbColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.disabled,
    MaterialState.selected,
  };

  if (states.any(interactiveStates.contains)) {
    return const Color(0xffbdbdbd);
  }

  return _AppColors.appPrimary;
}

Color getTrackColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.selected,
  };

  if (states.any(interactiveStates.contains)) {
    return _AppColors.appPrimary;
  }

  return const Color(0x1e000000);
}
