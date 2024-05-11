import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../model/data_model/booking_model.dart';

class BookingDetails extends StatelessWidget {
  final BookingModel turf;
  const BookingDetails({super.key, required this.turf});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final startTimeFormatted =
        DateFormat('dd-MM-yyyy HH:MM').format(turf.startTime);

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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                turf.turf.courtName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: width * 0.08),
              Text(
                turf.turf.courtLocation,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: width * 0.08),
              Text(
                startTimeFormatted,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: width * 0.08),
              // Text(
              //   turf.status,
              //   style: TextStyle(
              //       fontSize: 16,
              //       color: turf.status == 'approved'
              //           ? Colors.green
              //           : (turf.status == 'pending'
              //               ? Colors.yellow
              //               : Colors.red),
              //       fontWeight: FontWeight.bold),
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
