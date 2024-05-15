import 'package:flutter/material.dart';

import '../../../../../../model/controller/formater.dart';
import '../../../../../../model/controller/url.dart';
import '../../../../../../model/data_model/booking_model.dart';
import '../../../../turflist/screens/view_turf_details.dart';

class ViewBookingDetails extends StatelessWidget {
  final BookingModel booking;

  const ViewBookingDetails({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Booking Details',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildDetailRow(title: 'Turf Name', value: booking.turf.courtName),
            _buildDetailRow(title: 'Place', value: booking.turf.courtLocation),
            _buildDetailRow(
                title: 'Date',
                value: Formatter.dateTimetoString(booking.startTime)),
            _buildDetailRow(
                title: 'Time',
                value: Formatter.timeRange(booking.startTime, booking.endTime)),
            _buildDetailRow(
                title: 'Time', value: Formatter.formatCurrency(booking.price)),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            _buildDetailRow(title: 'Name', value: booking.username),
            _buildDetailRow(title: 'Email', value: booking.userEmail),
            _buildDetailRow(title: 'Phone', value: booking.userNumber),
            const SizedBox(height: 20),
            Text(
              'Slot ${booking.status}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: booking.status == 'approved'
                    ? Colors.green
                    : (booking.status == 'pending'
                        ? Colors.yellow
                        : Colors.red),
              ),
            ),
            const SizedBox(height: 20),
            whiteButton('Call', context, () {
              Url.makePhoneCall(booking.turf.courtPhoneNumber);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$title:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
