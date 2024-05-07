import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/portion/snackbar.dart';
import '../../../../view/course/head/bottom_navigationbar_widget.dart';
import '../firestore/user_repositories.dart';
import 'firebase_exceptionhandler.dart';

const logs = 'action';

class AuthenticationRepository {
  // static AuthenticationRepository get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get authUser => _auth.currentUser;

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user =
          await UserRepository().fetchUserdetails(userCredential.user!.uid);

      if (user.isUser) {
        await prefs.setStringList(logs, <String>[email, password]);
        Get.offAll(() => const MyBottomNavigationBar());
        log("SigninSuccess");
      } else {
        Get.back();
        CustomSnackbar.showError(
            'Your account has some issue. Please contact support for assistance.');
      }
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  // Sign out the current user using Firebase authentication
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
