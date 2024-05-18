import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../../../utils/const/colors.dart';
import '../../../../utils/const/image_name.dart';
import '../../../../view_model/course/turflist_controller.dart';
import '../../../../view_model/course/usermodel_controller.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
    Get.put(UserController());
    Get.put(TurflistController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your logo widget
            Image.asset(ImagePath.logo),

            // Circular progress indicator
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> checkUserLoggedIn() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(logs);
    if (items == null) {
      await Future.delayed(const Duration(seconds: 2));
      Get.off(() => const WelcomeScreen());
    } else {
      await AuthenticationRepository()
          .signInWithEmailAndPassword(items[0], items[1]);
    }
  } catch (e) {
    log('Error querying the database: $e');
  }
}
