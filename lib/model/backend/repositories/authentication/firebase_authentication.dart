import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../widget/portion/snackbar.dart';
import '../../../../view/course/head/bottom_navigationbar_widget.dart';
import '../firestore/user_repositories.dart';
import 'firebase_exceptionhandler.dart';

const logs = 'action';

class AuthenticationRepository extends GetxController {
  // Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Getter for the current authenticated user
  User? get authUser => _auth.currentUser;

  /// Register a user with email and password
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      // Save email and password in shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(logs, <String>[email, password]);

      // Create a new user with email and password
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      // Handle any exceptions that occur
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Sign in a user with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Get shared preferences instance
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch user details
      final user =
          await UserRepository().fetchUserdetails(userCredential.user!.uid);

      // Check if the user is valid
      if (user.isUser) {
        // Save email and password in shared preferences
        await prefs.setStringList(logs, <String>[email, password]);
        // Navigate to the bottom navigation bar widget
        Get.offAll(() => const MyBottomNavigationBar());
        log("SigninSuccess");
      } else {
        // If user is not valid, go back and show error message
        Get.back();
        CustomSnackbar.showError(
            'Your account has some issue. Please contact support for assistance.');
      }
    } catch (e) {
      // Handle any exceptions that occur
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Send a password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      // Send password reset email
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // Handle any exceptions that occur
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Sign out the current user
  Future<void> userLogout() async {
    try {
      // Log the current user's ID
      log(_auth.currentUser!.uid.toString());
      // Sign out the user
      await _auth.signOut();
    } catch (e) {
      // Handle any exceptions that occur
      throw ExceptionHandler.handleException(e);
    }
  }
}
