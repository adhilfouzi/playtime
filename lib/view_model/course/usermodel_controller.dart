import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    name.text = user.value.name;
    number.text = user.value.number;
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
      await UserRepository()
          .updateSpecificField(fieldName: fieldName, value: value);
      await getUserRecord();
    } catch (e) {
      log("updateUserField $fieldName: $e");
    }
  }

  Future<void> editUserDetail(
    String title,
  ) async {
    Get.defaultDialog(
      title: "Edit $title",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
                label: Text(
              title == "number" ? "Phone Number" : "Name",
            )),
            controller: title == "number" ? number : name,
            validator: (value) => title == "number"
                ? InputValidators.validatePhoneNumber(value)
                : InputValidators.validateEmpty("Name", value),
            keyboardType:
                title == "number" ? TextInputType.number : TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () async {
                  title == "number"
                      ? await updateUserField('number', number.text)
                      : await updateUserField('name', name.text);

                  Get.back();
                },
                child: const Text("Save"),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Back"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
