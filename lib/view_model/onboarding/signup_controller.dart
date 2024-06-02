import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../model/backend/repositories/firestore/user_repositories.dart';
import '../../model/data_model/user_model.dart';
import '../../widget/portion/loadingpopup.dart';
import '../../widget/portion/snackbar.dart';
import '../../view/course/head/bottom_navigationbar_widget.dart';
import '../course/usermodel_controller.dart';

class SignupController extends GetxController {
  final fullNameText = TextEditingController();
  final phoneNumberText = TextEditingController();
  final emailText = TextEditingController();
  final dobText = TextEditingController();
  final passwordText = TextEditingController();
  var isChecked = false.obs;

  void signup() async {
    try {
      if (!isChecked.value) {
        CustomSnackbar.showError("Need to accept the privacy & policy");
        return;
      }
      Get.to(() => const LoadingPopup());

      final userCredential = await AuthenticationRepository()
          .registerWithEmailAndPassword(
              emailText.text, passwordText.text.trim());
      final user = UserModel(
        id: userCredential.user!.uid,
        name: fullNameText.text.trim(),
        number: phoneNumberText.text.trim(),
        email: emailText.text.trim(),
        profile: '',
        isUser: true,
      );
      await UserRepository().saveUserRecord(user, userCredential.user!.uid);
      await UserController().getUserRecord();
      Get.offAll(() => const MyBottomNavigationBar());

      fullNameText.clear();
      phoneNumberText.clear();
      emailText.clear();
      dobText.clear();
      passwordText.clear();
      isChecked.value = false;
    } catch (e) {
      Get.back();
      CustomSnackbar.showError(e.toString());
    }
  }
}
