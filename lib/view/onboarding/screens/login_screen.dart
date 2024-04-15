import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/controller/validator.dart';
import '../../../utils/const/image_name.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/textfield.dart';
import '../../../view_model/bloc/signin_bloc/signin_bloc.dart';
import '../../course/head/bottom_navigationbar_widget.dart';
import '../utils/appbar.dart';
import 'forget/forgetpassword/emailverification.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

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
          child: BlocListener<SigninBloc, SigninState>(
            listener: (context, state) {
              if (state is SigninSuccess) {
                // Navigate to home screen on success
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyBottomNavigationBar()));
              } else if (state is SigninError) {
                // Show error message
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
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
                    controller: emailTextEditingController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => InputValidators.validateEmail(value),
                  ),
                  PasswordTextField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordTextEditingController,
                  ),
                  SizedBox(height: height * 0.06),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EmailVerificationScreen()));
                      },
                      child: const Text("Forget password")),
                  Button().mainButton('Log in', context, () {
                    if (!loginFormKey.currentState!.validate()) return;
                    final email = emailTextEditingController.text;
                    final password = passwordTextEditingController.text;
                    context.read<SigninBloc>().add(SigninRequested(
                        email: email, password: password, context: context));
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignupScreen()));
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
      ),
    );
  }
}
