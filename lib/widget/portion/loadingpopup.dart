import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../const/colors.dart';

class LoadingPopup extends StatelessWidget {
  const LoadingPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog.fullscreen(
      child: Center(
        child: SpinKitCircle(
          color: CustomColor.mainColor,
          size: 50.0, // Change size as needed
        ),
      ),
    );
  }
}
