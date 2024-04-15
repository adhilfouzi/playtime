import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../model/controller/validator.dart';
import '../../../../../utils/portion/button.dart';
import '../../../../../utils/portion/snackbar.dart';
import '../../../../../utils/portion/textfield.dart';
import '../../../../../view_model/bloc/emailverification/emailverification_bloc.dart';
import 'sentemail_screen.dart';

class EmailVerificationScreen extends StatelessWidget {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();

  EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<EmailVerificationBloc, EmailVerificationState>(
        listener: (context, state) {
          if (state is EmailVerificationError) {
            CustomSnackBar.showError(context, state.error);
            Navigator.of(context).pop();
          } else if (state is EmailVerificationSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SentEmailScreen(
                      email: emailTextEditingController.text,
                    )));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Don't worry, it happens! Enter your email below, and we'll send you a password reset link.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Form(
                key: emailFormKey,
                child: MyTextField(
                  textInputAction: TextInputAction.next,
                  controller: emailTextEditingController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => InputValidators.validateEmail(value),
                ),
              ),
              const SizedBox(height: 32),
              Button().mainButton(
                'Send Reset Link',
                context,
                () {
                  if (!emailFormKey.currentState!.validate()) return;
                  final email = emailTextEditingController.text.trim();
                  context.read<EmailVerificationBloc>().add(
                      EmailVerificationRequested(
                          email: email, context: context));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
