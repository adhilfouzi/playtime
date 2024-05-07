import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/controller/validator.dart';
import '../../../utils/const/image_name.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/textfield.dart';
import '../utils/appbar.dart';
import 'controller/sign_controller.dart';
import 'forget/forgetpassword/emailverification.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final SigninController _controller = Get.put(SigninController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: const IntroAppbar(
          actions: [],
          titleText: 'Log in',
        ),
        body: SingleChildScrollView(
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: height * 0.25,
                  width: width,
                  child: Image.asset(ImagePath.logo),
                ),
                MyTextField(
                  textInputAction: TextInputAction.next,
                  controller: _controller.emailTextEditingController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => InputValidators.validateEmail(value),
                ),
                PasswordTextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _controller.passwordTextEditingController,
                ),
                SizedBox(height: height * 0.06),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EmailVerificationScreen()));
                  },
                  child: const Text("Forget password"),
                ),
                Button().mainButton('Log in', context, () {
                  if (!loginFormKey.currentState!.validate()) return;

                  _controller.signIn();
                }),
                SizedBox(height: height * 0.025),
                const Text('or'),
                SizedBox(height: height * 0.025),
                Button().googleSignInButton(context, false),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don’t have an account? '),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()),
                            (route) => false);
                      },
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
