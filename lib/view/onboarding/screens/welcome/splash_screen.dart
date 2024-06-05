import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../model/backend/repositories/firestore/user_repositories.dart';
import '../../../../widget/const/colors.dart';
import '../../../../widget/const/image_name.dart';
import '../../../../view_model/course/turf_controller.dart';
import '../../../../view_model/course/usermodel_controller.dart';
import 'welcome_screen.dart';
import '../../../../view/course/head/bottom_navigationbar_widget.dart';

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
    Get.put(TurfController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagePath.logo),
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

  Future<void> checkUserLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      await Future.delayed(const Duration(seconds: 2));
      Get.off(() => const WelcomeScreen());
    } else {
      try {
        final userDetails = await UserRepository().fetchUserdetails(user.uid);
        if (userDetails.isUser) {
          Get.off(() => const MyBottomNavigationBar());
        } else {
          await FirebaseAuth.instance.signOut();
          Get.off(() => const WelcomeScreen());
        }
      } catch (e) {
        log('Error querying the database: $e');
        Get.off(() => const WelcomeScreen());
      }
    }
  }
}
