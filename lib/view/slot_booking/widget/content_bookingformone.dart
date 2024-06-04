import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../model/controller/formater.dart';
import '../../../widget/portion/snackbar.dart';
import '../../../view_model/course/booking_controller.dart';
import 'calender.dart';
import 'display_total_price.dart';
import 'time_picker_container.dart';
import 'time_selection_container.dart';

class BookingFormContent extends StatefulWidget {
  final BookingController controller;

  const BookingFormContent({
    super.key,
    required this.controller,
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.05),
        child: Column(
          children: [
            BookingCalendar(
              onDateSelected: _onDateSelected,
            ),
            SizedBox(height: height * 0.02),
            TimeSelectionContainer(
              height: height,
              width: width,
              openingTime: _openingTime,
              closingTime: _closingTime,
              onOpeningTimePressed: () => _selectTime(context, true),
              onClosingTimePressed: () => _selectTime(context, false),
            ),
            SizedBox(height: height * 0.02),
            TotalPriceDisplay(price: widget.controller.price.value),
          ],
        ),
      ),
    );
  }

  void _onDateSelected(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
      widget.controller.selectedDate.value = _selectedDate;
      widget.controller.bookedSlots();
    });
  }

  Future<void> _selectTime(BuildContext context, bool isOpening) async {
    if (!isOpening && _openingTime == null) {
      CustomSnackbar.showError('Please select the starting time.');
      return;
    }

    final openingTime = _getOpeningTime(isOpening);
    final closingTime = _getClosingTime(isOpening);
    final initialTime = isOpening ? _openingTime : _closingTime;

    final selectedTime = await _showTimePickerDialog(
      context,
      initialTime,
      isOpening,
      openingTime,
      closingTime,
    );

    if (selectedTime != null) {
      _handleSelectedTime(isOpening, selectedTime);
    }
  }

  TimeOfDay _getOpeningTime(bool isOpening) {
    return isOpening
        ? parseTimeFromString(widget.controller.turf.value.openingTime, false)
        : _openingTime!;
  }

  TimeOfDay _getClosingTime(bool isOpening) {
    return parseTimeFromString(
        widget.controller.turf.value.closingTime, isOpening);
  }

  Future<TimeOfDay?> _showTimePickerDialog(
    BuildContext context,
    TimeOfDay? initialTime,
    bool isOpening,
    TimeOfDay openingTime,
    TimeOfDay closingTime,
  ) {
    return showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return TimePickerDialogBox(
          initialTime: initialTime ?? TimeOfDay.now(),
          isOpening: isOpening,
          closingTime: closingTime,
          openingTime: openingTime,
        );
      },
    );
  }

  void _handleSelectedTime(bool isOpening, TimeOfDay selectedTime) {
    setState(() {
      if (isOpening) {
        _openingTime = selectedTime;
        _closingTime =
            TimeOfDay(hour: selectedTime.hour + 1, minute: selectedTime.minute);
      } else {
        _validateAndSetClosingTime(selectedTime);
      }

      widget.controller.startTime.value = _openingTime!;
      widget.controller.endTime.value = _closingTime!;
      widget.controller.price.value = Formatter.calculateTotalPrice(
          widget.controller.turf.value.price, _openingTime!, _closingTime!);
    });
  }

  void _validateAndSetClosingTime(TimeOfDay selectedTime) {
    final difference = selectedTime.hour - _openingTime!.hour;
    log(difference.toString());
    if (difference >= 1 && difference <= 6) {
      setState(() {
        _closingTime = selectedTime;
      });
    } else {
      _showErrorForInvalidDuration(difference);
    }
  }

  void _showErrorForInvalidDuration(int difference) {
    if (difference < 1) {
      CustomSnackbar.showError('Minimum booking duration is limited to 1 hour');
    } else {
      CustomSnackbar.showError(
          'Maximum booking duration is limited to 6 hours');
    }
  }

  TimeOfDay parseTimeFromString(TimeOfDay time, bool isOpening) {
    int hours = time.hour;
    int minutes = time.minute;

    if (isOpening && hours != 0) {
      hours--;
    } else if (isOpening) {
      hours = 23;
    }

    return TimeOfDay(hour: hours, minute: minutes);
  }
}
