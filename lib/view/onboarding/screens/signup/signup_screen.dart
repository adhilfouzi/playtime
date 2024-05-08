import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../model/controller/validator.dart';
import '../../../../utils/const/image_name.dart';
import '../../../../utils/portion/button.dart';
import '../../../../utils/portion/textfield.dart';
import '../../utils/appbar.dart';
import '../../utils/privacy_policy_checkbox.dart';
import '../../../../view_model/onboarding/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final SignupController _signupController = Get.put(SignupController());
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: const IntroAppbar(actions: [], titleText: 'Sign up'),
        body: SingleChildScrollView(
          child: Form(
            key: signupFormKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.2,
                  width: width,
                  child: Image.asset(ImagePath.logo),
                ),
                MyTextField(
                  hintText: "Full Name",
                  validator: (value) =>
                      InputValidators.validateEmpty("Name", value),
                  controller: _signupController.fullNameText,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                MyTextField(
                  hintText: 'Phone Number',
                  controller: _signupController.phoneNumberText,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      InputValidators.validatePhoneNumber(value),
                ),
                MyTextField(
                  hintText: 'Email',
                  controller: _signupController.emailText,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => InputValidators.validateEmail(value),
                  textInputAction: TextInputAction.next,
                ),
                PasswordTextField(
                  textInputAction: TextInputAction.done,
                  hintText: 'Enter Password',
                  keyboardType: TextInputType.visiblePassword,
                  controller: _signupController.passwordText,
                ),
                PrivacyPolicyCheckbox(controller: _signupController),
                SizedBox(height: height * 0.02),
                Button().mainButton('Sign up', context, () {
                  if (!signupFormKey.currentState!.validate()) return;
                  _signupController.signup();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
