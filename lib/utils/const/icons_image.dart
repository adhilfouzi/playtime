import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static const String home = 'assets/icons/home.svg';
  static const String homeOutlined = 'assets/icons/home_outlined.svg';
  static const String football = 'assets/icons/football.svg';
  static const String footballOutlined = 'assets/icons/football_outlined.svg';
  static const String newspaper = 'assets/icons/newspaper.svg';
  static const String newspaperOutlined = 'assets/icons/newspaper_outlined.svg';
  static const String user = 'assets/icons/user.svg';
  static const String userOutlined = 'assets/icons/user_outlined.svg';
  static const String notification = 'assets/icons/bell.svg';
  static const String handWave = 'assets/icons/waving-hand-svgrepo-com.svg';
}

class AppIconConverter {
  AppIconConverter(String handWave);

  static SvgPicture fromAsset(
    String asset, {
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      asset,
      width: width ?? 24,
      height: height ?? 24,
      color: color, // Deprecated, but still needs to be passed
    );
  }
}
