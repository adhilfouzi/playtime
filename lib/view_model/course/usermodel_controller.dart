import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/utils/portion/snackbar.dart';
import '../../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../model/backend/repositories/firestore/user_repositories.dart';
import '../../model/data_model/user_model.dart';

class UserController extends GetxController {
  // static UserController get instance => Get.find();
  Rx<UserModel> user = UserModel.emptyUserModel().obs;
  final name = TextEditingController();
  final number = TextEditingController();

  @override
  void onReady() async {
    await getUserRecord();
    name.text = user.value.name;
    number.text = user.value.number;
    super.onReady();
  }

  Future<void> getUserRecord() async {
    try {
      var authenticationRepository = Get.put(AuthenticationRepository());

      final authUser = authenticationRepository.authUser;
      var userRepository = Get.put(UserRepository());

      if (authUser != null) {
        final userd = await userRepository.getUserById();
        user(userd);
      }
    } catch (e) {
      user(UserModel.emptyUserModel());
      log("getUserRecord failed");
      log(e.toString());
    }
  }

  Future<void> updateUser() async {
    try {
      var userModel = UserModel(
          name: name.text,
          number: number.text,
          email: user.value.email,
          profile: user.value.profile,
          isUser: user.value.isUser);
      await UserRepository().updateUserField(userMdel: userModel);
      user.value = userModel;
    } catch (e) {
      log('updateUser:$e');
      CustomSnackbar.showError(e.toString());
    }
  }
}
