import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:users_side_of_turf_booking/utils/appbar/titleonly_appbar.dart';
import '../../../../../../model/controller/formater.dart';
import '../../../../../../model/controller/url.dart';
import '../../../../../../model/data_model/booking_model.dart';
import '../../../../../../utils/portion/button.dart';
import 'detail_row_view_screen.dart';

class ViewBookingDetailsScreen extends StatelessWidget {
  final BookingModel booking;

  const ViewBookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const TitleOnlyAppBar(title: 'Booking Details'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DetailRow(title: 'Turf Name', value: booking.turf.courtName),
                DetailRow(title: 'Place', value: booking.turf.courtLocation),
                DetailRow(
                    title: 'Date',
                    value: Formatter.dateTimetoString(booking.startTime)),
                DetailRow(
                    title: 'Time',
                    value: Formatter.timeRange(
                        booking.startTime, booking.endTime)),
                DetailRow(
                    title: 'Price',
                    value: Formatter.formatCurrency(booking.price)),
                const SizedBox(height: 10),
                const Divider(),
                DetailRow(
                    title: 'Price',
                    value: Formatter.formatCurrency(booking.price)),
                DetailRow(
                    title: 'Paid',
                    value: Formatter.formatCurrency(booking.paid)),
                DetailRow(
                    title: 'Discount',
                    value: Formatter.formatCurrency(booking.discount)),
                DetailRow(
                    title: 'Balance',
                    value: Formatter.formatCurrency(booking.balance)),
                const Divider(),
                const SizedBox(height: 10),
                DetailRow(title: 'Name', value: booking.username),
                DetailRow(title: 'Email', value: booking.userEmail),
                DetailRow(title: 'Phone', value: booking.userNumber),
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button().mainButton('Call', context, () {
                Url.makePhoneCall(booking.turf.courtPhoneNumber);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
