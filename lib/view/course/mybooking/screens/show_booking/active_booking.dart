import 'package:flutter/material.dart';

import '../../../../../utils/portion/button.dart';

class ActiveBooking extends StatelessWidget {
  const ActiveBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(
            vertical: height * 0.01,
            horizontal: width * 0.02,
          ),
          child: Padding(
            padding: EdgeInsets.all(width * 0.02),
            child: Column(
              children: [
                BookingDetails(),
                SizedBox(height: height * 0.01),
                Button().mainButton("View Booking", context, () {
                  // Add action for button press
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BookingDetails extends StatelessWidget {
  const BookingDetails({super.key});

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
