import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Formatter {
  static String dateTimetoString(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    final formatCurrency = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    return formatCurrency.format(amount);
  }

  static String timeRange(DateTime start, DateTime end) {
    String startTime = DateFormat('hh:mm a').format(start);
    String endTime = DateFormat('hh:mm a').format(end);
    return '$startTime to $endTime';
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Assuming the phone number format is 10 digits
    return '${phoneNumber.substring(0, 5)}-${phoneNumber.substring(5, 10)}'; // Example: 12345-67890
  }

  static double firebaseNumberToDouble(num firebaseNumber) {
    return firebaseNumber.toDouble();
  }

  static DateTime timestampToDateTime(Timestamp timestamp) {
    return timestamp.toDate();
  }

  static double calculateTotalPrice(
    double pricePerHour,
    TimeOfDay startTime,
    TimeOfDay endTime,
  ) {
    // Convert TimeOfDay to DateTime
    DateTime startDateTime =
        DateTime(2002, 5, 22, startTime.hour, startTime.minute);
    DateTime endDateTime = DateTime(2002, 5, 22, endTime.hour, endTime.minute);

    // Calculate the duration of the booking in hours
    double durationInHours =
        endDateTime.difference(startDateTime).inHours.toDouble();

    // Calculate the total price
    double totalPrice = durationInHours * pricePerHour;

    return totalPrice;
  }

  static String timestampToString(Timestamp timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm aa').format(timestamp.toDate());
  }

  static TimeOfDay timestampToTimeOfDay(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  static Timestamp dateTimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }

  static Timestamp timeOfDayToTimestamp(TimeOfDay timeOfDay) {
    return Timestamp.fromDate(
        DateTime(2002, 5, 22, timeOfDay.hour, timeOfDay.minute));
  }

  static String timeOfDayToString(TimeOfDay timeOfDay) {
    // Determine if it's AM or PM
    final period = timeOfDay.hour >= 12 ? 'PM' : 'AM';

    // Convert hours to 12-hour format
    int hour = timeOfDay.hourOfPeriod;
    if (hour == 0) {
      hour = 12; // 12 AM
    }

    // Format minutes with leading zero if needed
    String minute =
        timeOfDay.minute < 10 ? '0${timeOfDay.minute}' : '${timeOfDay.minute}';

    // Construct the formatted time string
    return '$hour:$minute $period';
  }

  static DateTime stringToDateTime(String dateString) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateString);
  }

  static TimeOfDay stringToTimeOfDay(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
