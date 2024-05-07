import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/const/image_name.dart';
import '../../../utils/portion/button.dart';
import 'onboarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              // Assuming the image is stored in assets folder
              ImagePath.welcome,
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // First text "Find your ideal Turf to play"
                const Text(
                  'Find your ideal\nTurf to play',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                // Second text "Discover the best turf..."
                const Text(
                  'Discover the best turf at \ngreat prices when you search\nwith spot me',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                // Third text "Search through 10,234 Turf in India"
                const Text(
                  'Search through 10,234 Turf in India',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                // Button "Get Started"
                Button().mainButton('Get Started', context, () {
                  Get.to(() => const OnboardingScreen());
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
