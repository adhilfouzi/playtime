import 'package:flutter/material.dart';

class CustomColor {
  ///mainColor
  ///secondarybackgroundColor
  ///unselected
  ///
  ///slotavailable
  ///slotunavailable
  ///slotbooked
  ///slotformembership

  static const MaterialColor mainColor =
      MaterialColor(_mainColorPrimaryValue, <int, Color>{
    50: Color(0xFFE5F1F3),
    100: Color(0xFFBDDDE0),
    200: Color(0xFF91C6CC),
    300: Color(0xFF65AFB7),
    400: Color(0xFF449DA7),
    500: Color(_mainColorPrimaryValue),
    600: Color(0xFF1F8490),
    700: Color(0xFF1A7985),
    800: Color(0xFF156F7B),
    900: Color(0xFF0C5C6A),
  });
  static const int _mainColorPrimaryValue = 0xFF238C98;

  static const MaterialColor mainColorAccent =
      MaterialColor(_mainColorAccentValue, <int, Color>{
    100: Color(0xFF9CEFFF),
    200: Color(_mainColorAccentValue),
    400: Color(0xFF36DEFF),
    700: Color(0xFF1DDAFF),
  });
  static const int _mainColorAccentValue = 0xFF69E7FF;

  ///=======================================================================
  ///=======================================================================
  ///=======================================================================
  ///=======================================================================
  ///=======================================================================

  static const MaterialColor slotavailable =
      MaterialColor(_slotavailablePrimaryValue, <int, Color>{
    50: Color(0xFFFFF9F9),
    100: Color(0xFFFFEFEF),
    200: Color(0xFFFFE5E5),
    300: Color(0xFFFFDADA),
    400: Color(0xFFFFD2D2),
    500: Color(_slotavailablePrimaryValue),
    600: Color(0xFFFFC5C5),
    700: Color(0xFFFFBDBD),
    800: Color(0xFFFFB7B7),
    900: Color(0xFFFFABAB),
  });
  static const int _slotavailablePrimaryValue = 0xFFFFCACA;

  static const MaterialColor slotavailableAccent =
      MaterialColor(_slotavailableAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_slotavailableAccentValue),
    400: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
  });
  static const int _slotavailableAccentValue = 0xFFFFFFFF;

  ///=======================================================================
  ///=======================================================================
  ///=======================================================================
  ///=======================================================================
  ///=======================================================================

  static const MaterialColor secondarybackgroundColor =
      MaterialColor(_secondarybackgroundColorPrimaryValue, <int, Color>{
    50: Color(0xFFFEFEFE),
    100: Color(0xFFFCFCFC),
    200: Color(0xFFFAFAFA),
    300: Color(0xFFF7F7F7),
    400: Color(0xFFF6F6F6),
    500: Color(_secondarybackgroundColorPrimaryValue),
    600: Color(0xFFF3F3F3),
    700: Color(0xFFF1F1F1),
    800: Color(0xFFEFEFEF),
    900: Color(0xFFECECEC),
  });
  static const int _secondarybackgroundColorPrimaryValue = 0xFFF4F4F4;

  static const MaterialColor secondarybackgroundColorAccent =
      MaterialColor(_secondarybackgroundColorAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_secondarybackgroundColorAccentValue),
    400: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
  });
  static const int _secondarybackgroundColorAccentValue = 0xFFFFFFFF;

  ///=======================================================================
  ///=======================================================================
  ///=======================================================================
  ///=======================================================================
  ///=======================================================================

  static const MaterialColor slotformembership =
      MaterialColor(_slotformembershipPrimaryValue, <int, Color>{
    50: Color(0xFFE8EDFB),
    100: Color(0xFFC6D2F6),
    200: Color(0xFFA0B4F0),
    300: Color(0xFF7A96EA),
    400: Color(0xFF5E80E6),
    500: Color(_slotformembershipPrimaryValue),
    600: Color(0xFF3B61DD),
    700: Color(0xFF3256D9),
    800: Color(0xFF2A4CD5),
    900: Color(0xFF1C3BCD),
  });
  static const int _slotformembershipPrimaryValue = 0xFF4169E1;

  static const MaterialColor slotformembershipAccent =
      MaterialColor(_slotformembershipAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_slotformembershipAccentValue),
    400: Color(0xFF9CABFF),
    700: Color(0xFF8395FF),
  });
  static const int _slotformembershipAccentValue = 0xFFCFD6FF;

  ///=======================================================================
  ///=======================================================================
  ///=======================================================================
  ///=======================================================================
  ///=======================================================================

  static const MaterialColor slotbooked =
      MaterialColor(_slotbookedPrimaryValue, <int, Color>{
    50: Color(0xFFFFE6E6),
    100: Color(0xFFFFC1C1),
    200: Color(0xFFFF9898),
    300: Color(0xFFFF6F6F),
    400: Color(0xFFFF5050),
    500: Color(_slotbookedPrimaryValue),
    600: Color(0xFFFF2C2C),
    700: Color(0xFFFF2525),
    800: Color(0xFFFF1F1F),
    900: Color(0xFFFF1313),
  });
  static const int _slotbookedPrimaryValue = 0xFFFF3131;

  static const MaterialColor slotbookedAccent =
      MaterialColor(_slotbookedAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_slotbookedAccentValue),
    400: Color(0xFFFFC7C7),
    700: Color(0xFFFFADAD),
  });
  static const int _slotbookedAccentValue = 0xFFFFFAFA;

  ///=======================================================================
  ///=======================================================================
  ///=======================================================================
  ///=======================================================================
  ///=======================================================================

  static const MaterialColor slotunavailable =
      MaterialColor(_slotunavailablePrimaryValue, <int, Color>{
    50: Color(0xFFF2F0F0),
    100: Color(0xFFDEDADA),
    200: Color(0xFFC8C1C1),
    300: Color(0xFFB2A8A8),
    400: Color(0xFFA29595),
    500: Color(_slotunavailablePrimaryValue),
    600: Color(0xFF897A7A),
    700: Color(0xFF7E6F6F),
    800: Color(0xFF746565),
    900: Color(0xFF625252),
  });
  static const int _slotunavailablePrimaryValue = 0xFF918282;

  static const MaterialColor slotunavailableAccent =
      MaterialColor(_slotunavailableAccentValue, <int, Color>{
    100: Color(0xFFFDCDCD),
    200: Color(_slotunavailableAccentValue),
    400: Color(0xFFFF6464),
    700: Color(0xFFFF4B4B),
  });
  static const int _slotunavailableAccentValue = 0xFFFA9C9C;

  ///=======================================================================
  ///=======================================================================
  ///=======================================================================
  ///=======================================================================
  ///=======================================================================

  static const MaterialColor unselected =
      MaterialColor(_unselectedPrimaryValue, <int, Color>{
    50: Color(0xFFF2F0F0),
    100: Color(0xFFDEDADA),
    200: Color(0xFFC8C1C1),
    300: Color(0xFFB2A8A8),
    400: Color(0xFFA29595),
    500: Color(_unselectedPrimaryValue),
    600: Color(0xFF897A7A),
    700: Color(0xFF7E6F6F),
    800: Color(0xFF746565),
    900: Color(0xFF625252),
  });
  static const int _unselectedPrimaryValue = 0xFF918282;

  static const MaterialColor unselectedAccent =
      MaterialColor(_unselectedAccentValue, <int, Color>{
    100: Color(0xFFFDCDCD),
    200: Color(_unselectedAccentValue),
    400: Color(0xFFFF6464),
    700: Color(0xFFFF4B4B),
  });
  static const int _unselectedAccentValue = 0xFFFA9C9C;
}
