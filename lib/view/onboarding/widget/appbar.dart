import 'package:flutter/material.dart';
import '../../../widget/const/colors.dart';

class IntroAppbar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final String titleText;
  final Color? backgroundColor;
  final Color? textcolor;
  final PreferredSizeWidget? bottom;

  const IntroAppbar({
    super.key,
    required this.actions,
    required this.titleText,
    this.backgroundColor,
    this.textcolor,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      foregroundColor: textcolor ?? Colors.black,
      backgroundColor: Colors.transparent,
      title: Text(
        titleText,
        style: const TextStyle(
          color: CustomColor.mainColor,
          fontSize: 24,
        ),
      ),
      actions: actions,
      // bottom: bottom ?? const BottomBorderWidget(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
