import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../const/image_name.dart';

class Button {
  Widget mainButton(
    String text,
    BuildContext context,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF238C98), // Text color
        minimumSize: Size(MediaQuery.of(context).size.width * 0.7,
            MediaQuery.of(context).size.height * 0.06), // Button width
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13), // Button corner radius
        ),
      ),
      child: Text(text),
    );
  }

  Widget whiteButton(
    String text,
    BuildContext context,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        minimumSize: Size(MediaQuery.of(context).size.width * 0.4,
            MediaQuery.of(context).size.height * 0.044), // Button width
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999), // Button corner radius
        ),
      ),
      child: Text(text),
    );
  }

  Widget googleSignInButton(BuildContext context, bool isBlack) {
    return ElevatedButton(
      onPressed: () {
        // _handleSignIn(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: isBlack ? Colors.white : Colors.black,
        backgroundColor: isBlack ? Colors.black : Colors.white,
        minimumSize: Size(
          MediaQuery.of(context).size.width * 0.83,
          MediaQuery.of(context).size.height * 0.06,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: BorderSide(
              color: isBlack ? Colors.white : Colors.black,
              width: 1), // Stroke color and width
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            ImagePath.googleLogo, // Replace with your Google logo asset
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 10),
          Text(
            'Login with Google',
            style: TextStyle(
              color: isBlack ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
