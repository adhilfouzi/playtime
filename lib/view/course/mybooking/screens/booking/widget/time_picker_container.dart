import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../widget/const/colors.dart';
import '../../../../../../view_model/course/booking_controller.dart';

class TimeSelector extends StatelessWidget {
  final String title;
  final TimeOfDay? time;
  final VoidCallback onPressed;

  const TimeSelector({
    super.key,
    required this.title,
    required this.time,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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

class TimePickerDialogBox extends StatelessWidget {
  final TimeOfDay initialTime;
  final TimeOfDay? openingTime;
  final TimeOfDay? closingTime;
  final bool isOpening;
  final BookingController booking = Get.find();

  TimePickerDialogBox({
    super.key,
    required this.initialTime,
    required this.openingTime,
    required this.closingTime,
    required this.isOpening,
  });

  @override
  Widget build(BuildContext context) {
    final list = _calculateTime();
    return AlertDialog(
      title: const Text('Select Time'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: _calculateItemCount(),
          itemBuilder: (context, index) {
            final time = list[index];
            return ListTile(
              title: Text(
                DateFormat('hh:mm a').format(
                  DateTime(2022, 1, 1, time.hour, time.minute),
                ),
              ),
              onTap: () => Get.back(result: time),
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
    final selectedDate = booking.selectedDate.value;
    final today = DateTime.now();
    late final int startHour;
    if (selectedDate.month == today.month &&
        selectedDate.day == today.day &&
        isOpening) {
      startHour = today.hour + 1;
      log("true");
    } else {
      log('false');
      startHour = isOpening ? openingTime!.hour : openingTime!.hour + 1;
    }

    final endHour = closingTime!.hour;
    final endMinute = closingTime!.minute;
    log("startHour: $startHour,endHour:$endHour,endMinute:$endMinute  ");

    final bookedSlot = booking.bookedSlot;
    if (bookedSlot.isEmpty) {
      if (isOpening) {
        return ((endHour == 0 ? 24 : endHour) - startHour) * 2;
      } else {
        return (endHour == 0 ? 24 : endHour) - startHour;
      }
    } else {
      if (isOpening) {
        return (((endHour == 0 ? 24 : endHour) - startHour) * 2) -
            bookedSlot.length;
      } else {
        return ((endHour == 0 ? 24 : endHour) - startHour) - bookedSlot.length;
      }
    }
  }

  List<TimeOfDay> _calculateTime() {
    final bookedSlot = booking.bookedSlot;
    int numSlots = _calculateItemCount();
    final selectedDate = booking.selectedDate.value;
    final today = DateTime.now();
    late int startHour;

    if (selectedDate.month == today.month &&
        selectedDate.day == today.day &&
        isOpening) {
      startHour = today.hour + 1;
    } else {
      startHour = isOpening ? openingTime!.hour : openingTime!.hour + 1;
    }

    final startMinute = openingTime!.minute;
    final duration = isOpening ? 30 : 60; // Duration in minutes
    List<TimeOfDay> availableSlots = [];
    int offset =
        isOpening ? 1 : 0; // To skip the next 30 minutes if isOpening is true

    while (availableSlots.length < numSlots) {
      final totalMinutes =
          (startHour * 60 + startMinute + offset * duration) % (24 * 60);
      final hour = totalMinutes ~/ 60;
      final minute = totalMinutes % 60;
      TimeOfDay potentialTime = TimeOfDay(hour: hour, minute: minute);

      final potentialDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        potentialTime.hour,
        potentialTime.minute,
      );

      bool isTimeBooked = bookedSlot.any((bookedTime) {
        final bookedDateTime = DateTime(
          bookedTime.year,
          bookedTime.month,
          bookedTime.day,
          bookedTime.hour,
          bookedTime.minute,
        );

        final turfClosingBuffer =
            DateTime(2002, 1, 1, closingTime!.hour, closingTime!.minute)
                .subtract(const Duration(minutes: 30));
        final beforeBuffer =
            bookedDateTime.subtract(const Duration(minutes: 30));
        final afterBuffer = bookedDateTime.add(const Duration(minutes: 30));
        final closingBuffer = bookedDateTime.add(const Duration(minutes: 60));

        if (isOpening) {
          return potentialDateTime == bookedDateTime ||
              potentialDateTime == beforeBuffer ||
              potentialDateTime == afterBuffer ||
              potentialDateTime == turfClosingBuffer;
        } else {
          return potentialDateTime == bookedDateTime ||
              potentialDateTime == beforeBuffer ||
              potentialDateTime == afterBuffer ||
              potentialDateTime == closingBuffer;
        }
      });

      if (!isTimeBooked) {
        // The potential time is not booked
        availableSlots.add(potentialTime);
      }

      offset++; // Increment offset to calculate the next potential time slot
    }

    return availableSlots;
  }
}
