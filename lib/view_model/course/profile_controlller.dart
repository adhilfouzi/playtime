import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/backend/repositories/authentication/firebase_authentication.dart';
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
    const String emailAddress = 'adhilfouziofficial@gmail.com';
    const String emailSubject = 'Help_me';
    const String emailBody = 'Need_help';

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': emailSubject,
        'body': emailBody,
      },
    );
    try {
      await launchUrl(emailUri);
    } catch (e) {
      log('Error launching email: $e');
      CustomSnackbar.showError("Could not launching helpAndFAQs");
    }
  }

  static void privacyPolicy() async {
    final Uri url = Uri.parse(
        'https://www.privacypolicyonline.com/live.php?token=ustex5OuSD3QiMsFevppnrez5Umpo8Rk');

    try {
      await launchUrl(url);
    } catch (e) {
      CustomSnackbar.showError("Could not open privacy policy.");
    }
  }

  static void termsUse() async {
    final Uri url = Uri.parse(
        'https://www.privacypolicyonline.com/live.php?token=z9zYarkiLJgcFzbJ526uwVn6dBbZKq9i');
    try {
      await launchUrl(url);
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
