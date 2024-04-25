import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../utils/const/colors.dart';

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

class CustomBottomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Function()? leading;

  const CustomBottomAppBar({super.key, this.leading});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AppBar(
      leading: IconButton(
        icon: const Icon(Ionicons.chevron_back_outline),
        onPressed: leading ?? () => Navigator.of(context).pop(),
      ),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'BUSINESS ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: CustomColor.mainColor,
            ),
          ),
          Text(
            'Registration        ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: CustomColor.mainColor,
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.009, horizontal: width * 0.015),
          child: SizedBox(
            width: width * 0.54,
            child: const Text(
              'Enter your details and complete your registration',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 40);
}
