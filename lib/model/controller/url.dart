// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

import '../../widget/portion/snackbar.dart';

class Url {
  /// Function to make a phone call
  static Future<void> makePhoneCall(String phoneNumber) async {
    final url = 'tel:+91$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ${url.toString()}';
    }
  }

  /// Function to launch the help and FAQs email
  static Future<void> helpAndFAQs() async {
    const String emailAddress = 'adhilfouziofficial@gmail.com';
    const String emailSubject = 'Help_me';
    const String emailBody = 'Need_help';

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': emailSubject,
        'body': emailBody,
      },
    );

    try {
      await launchUrl(emailUri);
    } catch (e) {
      log('Error launching email: $e');
      CustomSnackbar.showError("Could not launch help and FAQs.");
    }
  }

  /// Function to launch the privacy policy URL
  static Future<void> privacyPolicy() async {
    const String privacyPolicyUrl =
        'https://www.privacypolicyonline.com/live.php?token=ustex5OuSD3QiMsFevppnrez5Umpo8Rk';
    final Uri url = Uri.parse(privacyPolicyUrl);

    try {
      await launchUrl(url);
    } catch (e) {
      CustomSnackbar.showError("Could not open privacy policy.");
    }
  }

  /// Function to launch the terms of use URL
  static Future<void> termsUse() async {
    const String termsUseUrl =
        'https://www.privacypolicyonline.com/live.php?token=z9zYarkiLJgcFzbJ526uwVn6dBbZKq9i';
    final Uri url = Uri.parse(termsUseUrl);

    try {
      await launchUrl(url);
    } catch (e) {
      CustomSnackbar.showError("Could not open terms of use.");
    }
  }
}
