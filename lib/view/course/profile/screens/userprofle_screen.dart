import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/const/image_name.dart';
import '../../../../view_model/course/usermodel_controller.dart';
import '../../../../view_model/course/profile_controlller.dart';
import '../../head/bottom_navigationbar_widget.dart';
import 'edit_profile.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final UserController controller = Get.find();

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
                Obx(() {
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
                }),
                SizedBox(height: screenHeight * 0.02),
                Obx(
                  () => Text(
                    controller.user.value.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          controller.user.value.number,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                CustomButton(
                  text: 'Profile',
                  onPressed: () {
                    Get.to(() => const EditUser());
                  },
                ),
                CustomButton(
                  text: 'Change Password',
                  onPressed: () {
                    ProfileController.changePassword(
                        controller.user.value.email);
                  },
                ),
                // CustomButton(
                //   text: 'Notification',
                //   onPressed: () {},
                // ),
                CustomButton(
                  text: 'Help & FAQs',
                  onPressed: () {
                    ProfileController.helpAndFAQs();
                  },
                ),
                CustomButton(
                  text: 'Privacy Policy',
                  onPressed: () {
                    ProfileController.privacyPolicy();
                  },
                ),
                CustomButton(
                  text: 'Terms & Use',
                  onPressed: () {
                    ProfileController.termsUse();
                  },
                ),
                CustomButton(
                  text: 'About Us',
                  onPressed: () {},
                ),
                CustomButton(
                  text: 'Log Out',
                  onPressed: () {
                    ProfileController.logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          alignment: Alignment.centerLeft, // Align text to left
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.008,
          ),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
