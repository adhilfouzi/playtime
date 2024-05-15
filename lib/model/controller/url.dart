// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';

class Url {
  // Function to make a phone call
  static Future<void> makePhoneCall(String phoneNumber) async {
    final url = 'tel:+91$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
