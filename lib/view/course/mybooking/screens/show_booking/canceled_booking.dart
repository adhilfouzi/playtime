import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CanceledBooking extends StatelessWidget {
  const CanceledBooking({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Center(
        child: Text('Canceled Booking'),
      ),
    );
  }
}
