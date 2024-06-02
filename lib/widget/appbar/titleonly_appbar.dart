import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class TitleOnlyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? centerTitle;
  final Widget? leading;

  const TitleOnlyAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: centerTitle,
      leading: leading ??
          IconButton(
            icon: const Icon(Ionicons.chevron_back_outline),
            onPressed: () {
              Get.back();
              FocusScope.of(context).unfocus();
            },
          ),
      backgroundColor: Colors.white, // Customize as needed
      elevation: 0, // Customize as needed
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
