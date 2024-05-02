// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_side_of_turf_booking/model/backend/repositories/authentication/firebase_authentication.dart';
import 'package:users_side_of_turf_booking/utils/portion/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:users_side_of_turf_booking/view/onboarding/screens/login_screen.dart';

class ProfileController {
  static void changePassword(context) async {
    try {
      await AuthenticationRepository()
          .sendPasswordResetEmail('adhilfouziofficial@gmail.com');
      CustomSnackBar.showInfo(
          context, "Password reset email sent successfully.");
    } catch (error) {
      CustomSnackBar.showError(context, "Failed to send password reset email.");
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
      // print('Error launching email: $e');
    }
  }

  static void privacyPolicy(context) async {
    final Uri url = Uri.parse(
        'https://www.freeprivacypolicy.com/live/23a6eb84-0360-4ce5-8580-53a24494b3dc');

    try {
      await launchUrl(url);
    } catch (e) {
      CustomSnackBar.showError(context, "Could not open privacy policy.");
    }
  }

  static void termsUse(context) async {
    final Uri url = Uri.parse(
        'https://www.freeprivacypolicy.com/live/cfe121cc-25c9-4882-a467-0f9bb8ab28da');
    try {
      await launchUrl(url);
    } catch (e) {
      CustomSnackBar.showError(context, "Could not open terms of use.");
    }
  }

  static void logout(context) async {
    // Call the logout function from Firebase or any other authentication service
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await AuthenticationRepository().logout();
      await prefs.remove(logs);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    } catch (e) {
      print("Error during logout: $e");

      CustomSnackBar.showError(
          context, "An error occurred during logout. Please try again.");
    }
  }
}
