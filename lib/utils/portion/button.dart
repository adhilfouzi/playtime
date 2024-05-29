import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../const/colors.dart';

class Button {
  Widget mainButton(
    String text,
    BuildContext context,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF238C98),
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.7,
            MediaQuery.of(context).size.height * 0.06,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  Widget smallBlueButton(
    String text,
    BuildContext context,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF238C98),
          minimumSize:
              Size(MediaQuery.of(context).size.width * 0.4, 50), // Button width
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999), // Button corner radius
          ),
        ),
        child: Text(text),
      ),
    );
  }

  Widget withAdd(
    String text,
    BuildContext context,
    VoidCallback onMainPressed,
    VoidCallback onAddPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: mainButton(text, context, onMainPressed),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          ElevatedButton(
            onPressed: onAddPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white, // Text (icon) color
              minimumSize: Size(
                MediaQuery.of(context).size.width * 0.1,
                MediaQuery.of(context).size.height * 0.06,
              ), // Button width
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: CustomColor.mainColor), // Stroke color
                borderRadius: BorderRadius.circular(13), // Button corner radius
              ),
            ),
            child: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
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

// Function to create white button with custom style
  Widget borderedWhiteButton(
      String text, BuildContext context, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF238C98),
        backgroundColor: Colors.white, // Text color
        minimumSize:
            Size(MediaQuery.of(context).size.width * 0.4, 50), // Button width
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999), // Button corner radius
          side:
              const BorderSide(color: Color(0xFF238C98)), // Button border color
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
            'assets/image/google_logo.svg', // Replace with your Google logo asset
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
