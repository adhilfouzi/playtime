import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/view/onboarding/screens/forget/forgetpassword/sentemail_screen.dart';

import '../../../../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../../../../utils/portion/loadingpopup.dart';

class EmailVerificationController extends GetxController {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final RxString error = ''.obs;

  void requestEmailVerification(BuildContext context) async {
    Get.to(() => const LoadingPopup());

    try {
      String email = emailTextEditingController.text.trim();
      await AuthenticationRepository().sendPasswordResetEmail(email);
      Get.to(() => const SentEmailScreen());
    } catch (e) {
      error.value = e.toString();
      Get.back();
    }
  }
}
