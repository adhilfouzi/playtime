import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../view_model/course/usermodel_controller.dart';
import '../../../../widget/const/image_name.dart';

class ProfilePicture extends StatelessWidget {
  final UserController controller;
  const ProfilePicture({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final imageUrl = controller.user.value.profile;
      return CircleAvatar(
        radius: 64.0,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            width: 128.0,
            height: 128.0,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 128.0,
                height: 128.0,
                color: Colors.white,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              ImagePath.profile,
              fit: BoxFit.cover,
              width: 128.0,
              height: 128.0,
            ),
          ),
        ),
      );
    });
  }
}

class ProfileName extends StatelessWidget {
  final UserController controller;
  const ProfileName({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        controller.user.value.name,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ProfileNumber extends StatelessWidget {
  final UserController controller;
  const ProfileNumber({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        controller.user.value.number,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
