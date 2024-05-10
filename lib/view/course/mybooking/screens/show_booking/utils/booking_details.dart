import 'package:flutter/material.dart';

import '../../../../../../model/data_model/booking_model.dart';

class BookingDetails extends StatelessWidget {
  final BookingModel turf;
  const BookingDetails({super.key, required this.turf});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width * 0.35,
          height: height * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 16 / 9, // Maintain aspect ratio
              child: Image.asset(
                "assets/image/turf_image.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        SizedBox(width: width * 0.05),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "The Pearls The Pearls The PearlsThe Pearls",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text(
                "GRA, Lagos",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text(
                "27 - March 2024",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
