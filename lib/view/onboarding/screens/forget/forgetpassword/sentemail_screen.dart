import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/portion/button.dart';
import '../../../controller/email_verification_controller.dart';
import '../../login_screen.dart';

class SentEmailScreen extends StatelessWidget {
  const SentEmailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final EmailVerificationController controller = Get.find();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Password Reset Email Sent',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              controller.emailTextEditingController.text,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const Text(
              "Your account security is our priority! We've sent you a secure link to safely change your password and keep your account protected.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Button().mainButton(
              'Done',
              context,
              () {
                Get.offAll(() => LoginScreen());
                controller.emailTextEditingController.clear();
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                controller.requestEmailVerification(context);
              },
              child: const Text(
                'Resend Email',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
