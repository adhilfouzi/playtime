import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/portion/button.dart';
import '../../../../../utils/portion/snackbar.dart';
import '../../../../../view_model/bloc/emailverification/emailverification_bloc.dart';
import '../../login_screen.dart';

class SentEmailScreen extends StatelessWidget {
  final String email;
  const SentEmailScreen({super.key, required this.email});

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
                      email: email,
                    )));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Password Reset Email Sent',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const Text(
                "Your account security is our priority! We've sent you a secure link to safely change your password and keep your account protected.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Button().mainButton(
                'Done',
                context,
                () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                  // Navigate to the next screen or perform necessary action
                },
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.read<EmailVerificationBloc>().add(
                      EmailVerificationRequested(
                          email: email, context: context));
                },
                child: const Text(
                  'Resend Email',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
