import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../model/controller/url.dart';
import '../../utils/portion/snackbar.dart';
import '../../view/onboarding/screens/login/login_screen.dart';

class ProfileController {
  static void changePassword(String email) async {
    try {
      await AuthenticationRepository().sendPasswordResetEmail(email);
      CustomSnackbar.showInfo("Password reset email sent successfully.");
    } catch (error) {
      CustomSnackbar.showError("Failed to send password reset email.");
    }
  }

  static void helpAndFAQs() async {
    try {
      await Url.helpAndFAQs();
    } catch (e) {
      CustomSnackbar.showError("Could not launch help and FAQs.");
    }
  }

  static void privacyPolicy() async {
    try {
      await Url.privacyPolicy();
    } catch (e) {
      CustomSnackbar.showError("Could not open privacy policy.");
    }
  }

  static void termsUse() async {
    try {
      await Url.termsUse();
    } catch (e) {
      CustomSnackbar.showError("Could not open terms of use.");
    }
  }

  static void logout() async {
    // Call the logout function from Firebase or any other authentication service
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await AuthenticationRepository().userLogout();
      await prefs.remove(logs);
      Get.offAll(() => LoginScreen());
    } catch (e) {
      log("Error during logout: $e");
      CustomSnackbar.showError(
          "An error occurred during logout. Please try again.");
    }
  }
}
