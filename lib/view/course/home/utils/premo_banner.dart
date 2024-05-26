import 'package:flutter/material.dart';
import 'package:users_side_of_turf_booking/utils/const/image_name.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: Colors.yellowAccent,
        width: width,
        height: height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.06,
              width: width * 0.6,
              child: Image.asset(ImagePath.logo, fit: BoxFit.contain),
            ),
            const SizedBox(height: 8),
            const Text(
              "Unleash Your Game, Secure Slot Reservation",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: height * 0.002),
            const Text(
              "Your Premier Hub for Effortless Sports Reservations",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
