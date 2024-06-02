import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendar extends StatefulWidget {
  final void Function(DateTime) onDateSelected; // Callback function

  const BookingCalendar({super.key, required this.onDateSelected});

  @override
  State<BookingCalendar> createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  late CalendarFormat _calendarFormat;
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF238C98).withOpacity(0.20),
        borderRadius: BorderRadius.circular(20), // Curved border
      ),
      padding: const EdgeInsets.all(20),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          widget.onDateSelected(selectedDay);
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
