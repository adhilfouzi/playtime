import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/controller/validator.dart';
import '../../../model/data_model/user_model.dart';
import '../../../utils/const/image_name.dart';
import '../../../utils/portion/button.dart';
import '../../../utils/portion/snackbar.dart';
import '../../../utils/portion/textfield.dart';
import '../../../view_model/bloc/signup_bloc/signup_bloc.dart';
import '../../../view_model/cubit/checkbox/checkbox_cubit.dart';
import '../../course/head/bottom_navigationbar_widget.dart';
import '../utils/appbar.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final fullNameTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final dobTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final checkboxCubit = context.read<CheckboxCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: const IntroAppbar(actions: [], titleText: 'Sign up'),
        body: SingleChildScrollView(
          child: Form(
            key: signupFormKey,
            child: BlocListener<SignupBloc, SignupState>(
              listener: (context, state) {
                if (state is SignupError) {
                  Navigator.of(context).pop();
                  CustomSnackBar.showError(context, state.error);
                } else if (state is SignupSuccess) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MyBottomNavigationBar()));
                }
              },
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
                    controller: fullNameTextEditingController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  MyTextField(
                    hintText: 'Phone Number',
                    controller: phoneNumberTextEditingController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        InputValidators.validatePhoneNumber(value),
                  ),
                  MyTextField(
                    hintText: 'Email',
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => InputValidators.validateEmail(value),
                    textInputAction: TextInputAction.next,
                  ),
                  PasswordTextField(
                    textInputAction: TextInputAction.done,
                    hintText: 'Enter Password',
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordTextEditingController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<CheckboxCubit, bool>(
                        builder: (context, isChecked) {
                          return Checkbox(
                            value: isChecked,
                            onChanged: (newValue) {
                              checkboxCubit.privacyPolicyChecked(newValue!);
                            },
                          );
                        },
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          'I agree with the Terms and Privacy Policy',
                          style: TextStyle(
                            // color: ,
                            fontSize: 11.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  Button().mainButton('Sign up', context, () {
                    if (!signupFormKey.currentState!.validate()) return;
                    if (checkboxCubit.state) {
                      UserModel user = UserModel(
                          name: fullNameTextEditingController.text.trim(),
                          number: phoneNumberTextEditingController.text.trim(),
                          email: emailTextEditingController.text.trim(),
                          password: passwordTextEditingController.text.trim(),
                          profile: '',
                          isUser: true);

                      context
                          .read<SignupBloc>()
                          .add(SignupRequested(user: user, context: context));
                    }
                  }),
                  SizedBox(height: height * 0.02),
                  const Text('or'),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an Account ?'),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          },
                          child: const Text('Login')),
                    ],
                  ),
                  SizedBox(height: height * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
