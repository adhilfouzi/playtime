import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/widget/portion/snackbar.dart';

import '../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../widget/portion/loadingpopup.dart';

class SigninController extends GetxController {
  final RxBool isLoading = false.obs;
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  void signIn() async {
    Get.to(() => const LoadingPopup());
    try {
      await AuthenticationRepository().signInWithEmailAndPassword(
          emailTextEditingController.text.trim(),
          passwordTextEditingController.text.trim());
      CustomSnackbar.showSuccess("welcome to play world");
      emailTextEditingController.clear();
      passwordTextEditingController.clear();
    } catch (e) {
      Get.back();
      CustomSnackbar.showError(e.toString());
      log("SigninError");
    }
  }

  void gooogleSignin() async {
    Get.to(() => const LoadingPopup());
    try {
      await AuthenticationRepository().signInWithGoogle();
      emailTextEditingController.clear();
      passwordTextEditingController.clear();
    } catch (e) {
      CustomSnackbar.showError(e.toString());
      log("gooogle Signin Error");
    }
  }
}
