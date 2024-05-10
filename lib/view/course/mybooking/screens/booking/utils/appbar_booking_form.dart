import 'package:flutter/material.dart';

class AppbarBookingForm extends StatelessWidget implements PreferredSizeWidget {
  const AppbarBookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Booking Form",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
