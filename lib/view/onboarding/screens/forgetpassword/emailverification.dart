import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../model/controller/validator.dart';
import '../../../../widget/portion/button.dart';
import '../../../../widget/portion/textfield.dart';
import '../../../../view_model/onboarding/email_verification_controller.dart';

class EmailVerificationScreen extends StatelessWidget {
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();

  final EmailVerificationController _controller =
      Get.put(EmailVerificationController());

  EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              "Don't worry, it happens! Enter your email below, and we'll send you a password reset link.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Form(
              key: emailFormKey,
              child: MyTextField(
                textInputAction: TextInputAction.next,
                controller: _controller.emailTextEditingController,
                hintText: "example@gmail.com",
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) => InputValidators.validateEmail(value),
              ),
            ),
            const SizedBox(height: 32),
            Button().mainButton(
              'Send Reset Link',
              context,
              () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (!emailFormKey.currentState!.validate()) return;
                _controller.requestEmailVerification(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
