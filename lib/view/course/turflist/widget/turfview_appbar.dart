import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/course/turf_controller.dart';

class TurfViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String turfid;

  const TurfViewAppBar({super.key, required this.turfid});

  @override
  Widget build(BuildContext context) {
    final TurfController controller = Get.find();

    // Initialize isLiked state
    controller.checkIfLiked(turfid);

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        onPressed: () {
          Get.back();
        },
      ),
      actions: [
        Obx(
          () => IconButton(
            onPressed: () async {
              bool currentStatus = controller.isLiked.value;
              await controller.liked(
                  turfId: turfid, isFavorite: !currentStatus);
              await controller.checkIfLiked(turfid);
            },
            icon: Icon(
              controller.isLiked.value ? Icons.star : Icons.star_border,
              color: controller.isLiked.value ? Colors.yellow : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
