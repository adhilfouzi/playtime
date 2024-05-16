import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/utils/const/image_name.dart';
import 'package:users_side_of_turf_booking/view/onboarding/utils/appbar.dart';

import '../../../../view_model/course/image_controller.dart';
import '../../../../view_model/course/usermodel_controller.dart';

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
              vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05),
              Obx(
                () => GestureDetector(
                  onTap: () => imagePicker.openDialog(),
                  child: CircleAvatar(
                    backgroundImage: user.user.value.profile.isNotEmpty
                        ? NetworkImage(user.user.value.profile)
                        : const AssetImage(ImagePath.profile) as ImageProvider,
                    radius: 64.0,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Name: "),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      user.user.value.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Add functionality to edit
                    },
                    icon: const Icon(Icons.edit_sharp),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Number: "),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      user.user.value.number,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Add functionality to edit
                    },
                    icon: const Icon(Icons.edit_sharp),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
