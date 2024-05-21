import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/utils/const/colors.dart';
import 'package:users_side_of_turf_booking/utils/const/image_name.dart';
import 'package:users_side_of_turf_booking/view/onboarding/utils/appbar.dart';
import 'package:users_side_of_turf_booking/view_model/course/image_controller.dart';
import 'package:users_side_of_turf_booking/view_model/course/usermodel_controller.dart';

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
                () => GestureDetector(
                  onTap: () => imagePicker.openDialog(),
                  child: CircleAvatar(
                    backgroundImage: user.user.value.profile.isNotEmpty
                        ? NetworkImage(user.user.value.profile)
                        : const AssetImage(ImagePath.profile) as ImageProvider,
                    radius: 80.0,
                    backgroundColor: Colors.grey.shade200,
                    child: const Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: CustomColor.mainColor,
                        radius: 20.0,
                        child: Icon(
                          Icons.camera_alt,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    buildEditableField(
                      label: 'Name',
                      value: user.user.value.name,
                      onEdit: () => user.editUserDetail('name'),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    buildEditableField(
                      label: 'Number',
                      value: user.user.value.number,
                      onEdit: () => user.editUserDetail('number'),
                    ),
                  ],
                ),
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
