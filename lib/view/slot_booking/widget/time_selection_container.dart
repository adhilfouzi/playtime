import 'package:flutter/material.dart';

import 'time_picker_container.dart';

class TimeSelectionContainer extends StatelessWidget {
  final double height;
  final double width;
  final TimeOfDay? openingTime;
  final TimeOfDay? closingTime;
  final VoidCallback onOpeningTimePressed;
  final VoidCallback onClosingTimePressed;

  const TimeSelectionContainer({
    super.key,
    required this.height,
    required this.width,
    required this.openingTime,
    required this.closingTime,
    required this.onOpeningTimePressed,
    required this.onClosingTimePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: const Color(0xFF238C98).withOpacity(0.20),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.05),
      child: Column(
        children: [
          const Text("Slide to check availability"),
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TimeSelector(
                title: 'From',
                time: openingTime,
                onPressed: onOpeningTimePressed,
              ),
              TimeSelector(
                title: 'To',
                time: closingTime,
                onPressed: onClosingTimePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
