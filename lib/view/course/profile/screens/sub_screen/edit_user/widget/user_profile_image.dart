import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../view_model/course/image_controller.dart';
import '../../../../../../../view_model/course/usermodel_controller.dart';
import '../../../../../../../widget/const/colors.dart';
import '../../../../../../../widget/const/image_name.dart';

class UserProfileImage extends StatelessWidget {
  final UserController user;
  final ImageController imagePicker;

  const UserProfileImage({
    super.key,
    required this.user,
    required this.imagePicker,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final imageUrl = user.user.value.profile;
        return Stack(
          children: [
            ClipOval(
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
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => imagePicker.openDialog(),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomColor.mainColor,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
