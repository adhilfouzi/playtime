import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../../utils/const/colors.dart';
import '../../../utils/const/image_name.dart';
import '../../course/head/bottom_navigationbar_widget.dart';
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
    checkUserLoggedIn(context);
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

Future<void> checkUserLoggedIn(context) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList(logs);
    if (items == null) {
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    } else {
      await AuthenticationRepository()
          .signInWithEmailAndPassword(items[0], items[1]);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const MyBottomNavigationBar()),
          (route) => false);
    }
  } catch (e) {
    log('Error querying the database: $e');
  }
}
