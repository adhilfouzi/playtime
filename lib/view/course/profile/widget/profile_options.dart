import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/view_model/course/usermodel_controller.dart';

import '../../../../view_model/course/profile_controlller.dart';
import '../screens/sub_screen/about_screen.dart';
import '../screens/sub_screen/edit_user/screen/edit_profile_screen.dart';
import 'profile_button.dart';

class ProfileOptions extends StatelessWidget {
  final UserController controller;
  const ProfileOptions({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileButton(
          text: 'Profile',
          onPressed: () {
            Get.to(() => const EditUser());
          },
        ),
        ProfileButton(
          text: 'Change Password',
          onPressed: () {
            ProfileController.changePassword(controller.user.value.email);
          },
        ),
        ProfileButton(
          text: 'Help & FAQs',
          onPressed: () {
            ProfileController.helpAndFAQs();
          },
        ),
        ProfileButton(
          text: 'Privacy Policy',
          onPressed: () {
            ProfileController.privacyPolicy();
          },
        ),
        ProfileButton(
          text: 'Terms & Use',
          onPressed: () {
            ProfileController.termsUse();
          },
        ),
        ProfileButton(
          text: 'About Us',
          onPressed: () {
            Get.to(() => const AboutUsScreen());
          },
        ),
        ProfileButton(
          text: 'Log Out',
          onPressed: () {
            ProfileController.logout();
          },
        ),
      ],
    );
  }
}
