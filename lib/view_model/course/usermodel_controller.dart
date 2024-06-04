import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/widget/const/colors.dart';
import '../../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../model/backend/repositories/firestore/user_repositories.dart';
import '../../model/controller/validator.dart';
import '../../model/data_model/user_model.dart';
import '../../widget/portion/snackbar.dart';

class UserController extends GetxController {
  // static UserController get instance => Get.find();
  Rx<UserModel> user = UserModel.emptyUserModel().obs;
  final name = TextEditingController();
  final number = TextEditingController();

  @override
  void onReady() async {
    super.onReady();
    await getUserRecord();
  }

  Future<void> getUserRecord() async {
    try {
      var authenticationRepository = Get.put(AuthenticationRepository());

      final authUser = authenticationRepository.authUser;
      var userRepository = Get.put(UserRepository());

      if (authUser != null) {
        final userd = await userRepository.getUserById();
        user(userd);
        name.text = user.value.name;
        number.text = user.value.number;
      }
      log("getUserRecord");
    } catch (e) {
      user(UserModel.emptyUserModel());
      log("getUserRecord failed: $e");
    }
  }

  Future<void> updateUser() async {
    try {
      var userModel = UserModel(
        name: name.text,
        number: number.text,
        email: user.value.email,
        profile: user.value.profile,
        isUser: user.value.isUser,
      );
      await UserRepository().updateUserField(userMdel: userModel);
      user.value = userModel;
      log("User updated successfully");
    } catch (e) {
      log('updateUser: $e');
      CustomSnackbar.showError("Failed to update user: $e");
    }
  }

  Future<void> updateUserField(String fieldName, String value) async {
    try {
      if (value.isNotEmpty) {
        await UserRepository()
            .updateSpecificField(fieldName: fieldName, value: value);
        await getUserRecord();
      } else {
        log('empty value');
        return;
      }
    } catch (e) {
      log("updateUserField $fieldName: $e");
    }
  }

  Future<void> editUserDetail(String title) async {
    Get.defaultDialog(
      title: "Edit $title",
      titleStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: CustomColor.mainColor,
      ),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: title == "Number" ? "Phone Number" : "Name",
                labelStyle: const TextStyle(color: CustomColor.mainColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              controller: title == "Number" ? number : name,
              validator: (value) => title == "number"
                  ? InputValidators.validatePhoneNumber(value)
                  : InputValidators.validateEmpty("Name", value),
              keyboardType:
                  title == "Number" ? TextInputType.number : TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColor.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    title == "Number"
                        ? await updateUserField('number', number.text)
                        : await updateUserField('name', name.text);

                    Get.back();
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    "Back",
                    style: TextStyle(color: CustomColor.mainColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      barrierDismissible: false,
      backgroundColor: Colors.white,
      radius: 12.0,
    );
  }
}
