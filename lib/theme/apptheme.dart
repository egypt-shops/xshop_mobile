import 'package:flutter/material.dart';

class AppTheme {
  static const colors = CompanyColors();
  const AppTheme._();

  static ThemeData define() {
    return ThemeData(primaryColor: Color(0x09485d));
  }
}

class CompanyColors {
  final cancel = const Color(0xffe11444);
  final textPrimary = const Color(0xffeeeeee);
  final textSecondry = const Color(0xff455a64);
  final primaryDark = const Color(0xff34515e);
  final primaryLight = const Color(0xffeceff1);
  final primary = const Color(0xff607d8b);
  final secondryDark = const Color(0xffc49000);
  final secondryLight = const Color(0xfffff263);
  final secondry = const Color(0xfffbc02d);

  const CompanyColors();
}
