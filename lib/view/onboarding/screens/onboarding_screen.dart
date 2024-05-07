import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../utils/const/image_name.dart';
import '../../../utils/portion/button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              // Assuming the image is stored in assets folder
              ImagePath.onboarding,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              // Adjust opacity as needed
              color: Colors.black.withOpacity(0.55),
            ),
          ),
          // Centered content
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // First text "Find your ideal Turf to play"
                  const Text(
                    'KEEP AN EYE ON THE STADIUM',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  // Second text "Discover the best turf..."
                  const Text(
                    'Watch sports live or highlights, read every news from your smartphone',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.5),
                  // Third text "Search through 10,234 Turf in India"
                  Row(
                    children: [
                      const Spacer(),
                      Button().whiteButton('Sign up', context, () {
                        Get.off(() => SignupScreen());
                      }),
                      const Spacer(),
                      Button().whiteButton('Login', context, () {
                        Get.off(() => LoginScreen());
                      }),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Button().googleSignInButton(context, true),
                  // Button "Get Started"
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
