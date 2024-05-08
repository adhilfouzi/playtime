import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../view_model/course/usermodel_controller.dart';
import '../../../../view_model/course/profile_controlller.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final UserController controller = Get.find();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.02, horizontal: screenWidth * 0.0052),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05),
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                    'assets/image/profile.png'), // Add your profile image asset
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                controller.user.value.name, // Replace with user's email
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.user.value.email, // Replace with user's email
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.08),
              _buildButton('Change Password', screenWidth, screenHeight, () {
                ProfileController.changePassword(controller.user.value.email);
              }),
              _buildButton('Notification', screenWidth, screenHeight, () {}),
              _buildButton('Help & FAQs', screenWidth, screenHeight, () {
                ProfileController.helpAndFAQs();
              }),
              _buildButton('Privacy Policy', screenWidth, screenHeight, () {
                ProfileController.privacyPolicy();
              }),
              _buildButton('Terms & Use', screenWidth, screenHeight, () {
                ProfileController.termsUse();
              }),
              _buildButton('About Us', screenWidth, screenHeight, () {}),
              _buildButton('Log Out', screenWidth, screenHeight, () {
                ProfileController.logout();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, double screenWidth, double screenHeight,
      VoidCallback onPressed) {
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
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.012),
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
