import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/view/onboarding/utils/appbar.dart';

import '../../../../model/controller/validator.dart';
import '../../../../utils/portion/button.dart';
import '../../../../utils/portion/textfield.dart';
import '../../../../view_model/course/usermodel_controller.dart';

class EditUser extends StatelessWidget {
  EditUser({super.key});
  final GlobalKey<FormState> _editUser = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserController user = Get.find();
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const IntroAppbar(actions: [], titleText: "Edit Profile"),
      body: Form(
        key: _editUser,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
              const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage(
                    'assets/image/profile.png'), // Add your profile image asset
              ),
              SizedBox(height: screenHeight * 0.05),
              MyTextField(
                hintText: "Full Name",
                validator: (value) =>
                    InputValidators.validateEmpty("Name", value),
                controller: user.name,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              MyTextField(
                hintText: 'Phone Number',
                controller: user.number,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    InputValidators.validatePhoneNumber(value),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Button().mainButton('Save', context, () {
          FocusManager.instance.primaryFocus?.unfocus();
          if (!_editUser.currentState!.validate()) return;
          user.updateUser();
          Get.back();
        }),
      ),
    );
  }
}
