import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:users_side_of_turf_booking/utils/portion/snackbar.dart';

import '../../../../utils/const/colors.dart';
import '../utils/appbar_booking_form.dart';
import '../utils/bottombar_bookingform.dart';
import '../utils/calender.dart';

class BookingFormOne extends StatelessWidget {
  const BookingFormOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarBookingForm(),
      body: BookingFormContent(),
      bottomNavigationBar: BookingFormBottomBar(),
    );
  }
}

class BookingFormContent extends StatefulWidget {
  const BookingFormContent({
    super.key,
  });

  @override
  State<BookingFormContent> createState() => _BookingFormContentState();
}

class _BookingFormContentState extends State<BookingFormContent> {
  late DateTime _selectedDate = DateTime.now();
  TimeOfDay? _openingTime;
  TimeOfDay? _closingTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          BookingCalendar(
            onDateSelected: (selectedDate) {
              setState(() {
                _selectedDate = selectedDate;
              });
            },
          ),
          Text(
            'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: const Color(0xFF238C98).withOpacity(0.20),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text("Slide to check availability"),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TimeSelector(
                      title: 'From',
                      time: _openingTime,
                      onPressed: () => _selectTime(context, true),
                    ),
                    TimeSelector(
                      title: 'To',
                      time: _closingTime,
                      onPressed: () => _selectTime(context, false),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime(context, bool isOpening) async {
    if (!isOpening && _openingTime == null) {
      CustomSnackBar.showError(context, 'Please select the starting time.');
      return;
    }

    final initialTime = isOpening ? _openingTime : _closingTime;
    final selectedTime = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return TimePickerDialog(
          closingTime: const TimeOfDay(hour: 2, minute: 00),
          openingTime:
              !isOpening ? _openingTime : const TimeOfDay(hour: 5, minute: 00),
          initialTime: initialTime ?? TimeOfDay.now(),
        );
      },
    );
    if (selectedTime != null) {
      // Check if selected time meets the condition
      if (isOpening) {
        setState(() {
          _openingTime = selectedTime;
          _closingTime = TimeOfDay(
              hour: selectedTime.hour + 1, minute: selectedTime.minute);
        });
      } else {
        final difference = selectedTime.hour - _openingTime!.hour;
        log(difference.toString());
        if (difference >= 1 && difference <= 6) {
          setState(() {
            _closingTime = selectedTime;
          });
        } else {
          if (difference < 1) {
            CustomSnackBar.showError(
                context, 'Minimum booking duration is limited to 1 hours');
          } else {
            CustomSnackBar.showError(
                context, 'Maximum booking duration is limited to 6 hours');
          }
        }
      }
    }
  }
}

class TimeSelector extends StatelessWidget {
  final String title;
  final TimeOfDay? time;
  final VoidCallback onPressed;

  const TimeSelector({
    Key? key,
    required this.title,
    required this.time,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 18,
                color: CustomColor.mainColor,
              ),
              const SizedBox(width: 4),
              Text(
                time != null ? _formatTime(time!) : '00:00',
                style: TextStyle(
                  fontSize: 16,
                  color: time != null ? CustomColor.mainColor : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hourOfPeriod;
    final minute = timeOfDay.minute;
    final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
    final formattedHour = hour == 0 ? 12 : hour; // Convert 0 to 12 for AM
    return '$formattedHour:${minute.toString().padLeft(2, '0')} $period';
  }
}

class TimePickerDialog extends StatelessWidget {
  final TimeOfDay initialTime;
  final TimeOfDay? openingTime;
  final TimeOfDay? closingTime;

  const TimePickerDialog({
    Key? key,
    required this.initialTime,
    required this.openingTime,
    required this.closingTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Time'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: _calculateItemCount(),
          itemBuilder: (context, index) {
            final time = _calculateTime(index);
            return ListTile(
              title: Text(
                DateFormat('hh:mm a').format(
                  DateTime(2022, 1, 1, time.hour, time.minute),
                ),
              ),
              onTap: () => Navigator.of(context).pop(time),
            );
          },
        ),
      ),
    );
  }

  int _calculateItemCount() {
    if (openingTime == null || closingTime == null) {
      return 0;
    }
    final startHour = openingTime!.hour;
    final endHour = closingTime!.hour;
    final endMinute = closingTime!.minute;
    final duration = closingTime!.periodOffset - openingTime!.periodOffset;

    // Check if the duration is at least 1 hour and at most 6 hours
    if (duration < Duration(hours: 1) || duration > Duration(hours: 6)) {
      return 0;
    }

    // Calculate the number of items based on the duration
    return (duration.inHours * 2) + 1;
  }

  TimeOfDay _calculateTime(int index) {
    final startHour = openingTime!.hour;
    final startMinute = openingTime!.minute;
    final totalMinutes =
        (startHour * 60 + startMinute + index * 30) % (24 * 60);
    final hour = totalMinutes ~/ 60;
    final minute = totalMinutes % 60;
    return TimeOfDay(hour: hour, minute: minute);
  }
}
