import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/const/colors.dart';

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

class TimePickerDialogBox extends StatelessWidget {
  final TimeOfDay initialTime;
  final TimeOfDay? openingTime;
  final TimeOfDay? closingTime;
  final bool isOpening;
  const TimePickerDialogBox({
    super.key,
    required this.initialTime,
    required this.openingTime,
    required this.closingTime,
    required this.isOpening,
  });

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
              onTap: () => Get.back(result: time),
//  Navigator.of(context).pop(time),
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

    final startHour = isOpening ? openingTime!.hour : openingTime!.hour + 1;
    final endHour = closingTime!.hour;
    final endMinute = closingTime!.minute;
    return endHour > startHour || (endHour == startHour && endMinute > 0)
        ? (endHour - startHour) * 2 + 1
        : (24 - startHour + endHour) * 2 + 1;
  }

  TimeOfDay _calculateTime(int index) {
    final startHour = isOpening ? openingTime!.hour : openingTime!.hour + 1;
    final startMinute = openingTime!.minute;
    final totalMinutes = isOpening
        ? (startHour * 60 + startMinute + index * 30) % (24 * 60)
        : (startHour * 60 + startMinute + index * 60) % (24 * 60);
    final hour = totalMinutes ~/ 60;
    final minute = totalMinutes % 60;
    return TimeOfDay(hour: hour, minute: minute);
  }
}
