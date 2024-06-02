import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showSuccess(String message) {
    GetSnackBar(
      message: message,
      borderRadius: 10,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    ).show();
  }

  static void showError(String message) {
    GetSnackBar(
      message: message,
      borderRadius: 10,
      icon: const Icon(
        Icons.warning_amber,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    ).show();
  }

  static void showInfo(String message) {
    GetSnackBar(
      message: message,
      borderRadius: 10,
      icon: const Icon(
        Icons.info_outline,
        color: Colors.white,
      ),
      backgroundColor: Colors.blue,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    ).show();
  }

  static void showWarning(String message) {
    GetSnackBar(
      message: message,
      backgroundColor: Colors.orange,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    ).show();
  }

  // Added GetX AlertDialog functionality
  static void showForgotPasswordDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Forgot Password?'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please contact the authority to recover your password:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Contact No: 9596939298',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Email: support@sportme.com',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
