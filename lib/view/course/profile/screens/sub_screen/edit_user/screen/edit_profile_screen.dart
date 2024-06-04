import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../view_model/course/image_controller.dart';
import '../../../../../../../view_model/course/usermodel_controller.dart';
import '../../../../../../onboarding/widget/appbar.dart';
import '../widget/user_details.dart';
import '../widget/user_profile_image.dart';

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
              UserProfileImage(user: user, imagePicker: imagePicker),
              SizedBox(height: screenHeight * 0.05),
              UserDetails(user: user, screenHeight: screenHeight),
            ],
          ),
        ),
      ),
    );
  }
}
