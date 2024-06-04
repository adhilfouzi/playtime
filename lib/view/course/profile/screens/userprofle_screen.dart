import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../view_model/course/usermodel_controller.dart';
import '../../head/bottom_navigationbar_widget.dart';
import '../widget/profile_options.dart';
import '../widget/user_info.dart';

class UserProfile extends StatelessWidget {
  final UserController controller;
  const UserProfile({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        Get.offAll(fullscreenDialog: true, const MyBottomNavigationBar());
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.01, horizontal: screenWidth * 0.0052),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                ProfilePicture(controller: controller),
                SizedBox(height: screenHeight * 0.02),
                ProfileName(controller: controller),
                ProfileNumber(controller: controller),
                SizedBox(height: screenHeight * 0.04),
                ProfileOptions(controller: controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
