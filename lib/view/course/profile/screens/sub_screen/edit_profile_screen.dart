import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../widget/const/colors.dart';
import '../../../../../widget/const/image_name.dart';
import '../../../../../view_model/course/image_controller.dart';
import '../../../../../view_model/course/usermodel_controller.dart';
import '../../../../onboarding/widget/appbar.dart';

class EditUser extends StatelessWidget {
  const EditUser({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController user = Get.find();
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final ImageController imagePicker = Get.put(ImageController());

    return SafeArea(
      child: Scaffold(
        appBar: const IntroAppbar(
          actions: [],
          titleText: "Profile",
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
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
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() => Column(
                      children: [
                        buildEditableField(
                          label: 'Name',
                          value: user.user.value.name,
                          onEdit: () => user.editUserDetail('Name'),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        buildEditableField(
                          label: 'Number',
                          value: user.user.value.number,
                          onEdit: () => user.editUserDetail('Number'),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableField(
      {required String label,
      required String value,
      required VoidCallback onEdit}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        IconButton(
          onPressed: onEdit,
          icon: const Icon(Icons.edit, color: CustomColor.mainColor),
        ),
      ],
    );
  }
}
