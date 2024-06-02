import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A utility class for various formatting tasks
class Formatter {
  /// Formats a DateTime object to a string in the format 'dd MMMM yyyy'
  static String dateTimetoString(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  /// Formats a given amount to Indian currency format with the symbol '₹'
  static String formatCurrency(double amount) {
    final formatCurrency = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    return formatCurrency.format(amount);
  }

  /// Returns a string representing a time range from start to end
  static String timeRange(DateTime start, DateTime end) {
    String startTime = DateFormat('hh:mm a').format(start);
    String endTime = DateFormat('hh:mm a').format(end);
    return '$startTime to $endTime';
  }

  /// Formats a 10-digit phone number by adding a hyphen after the fifth digit
  static String formatPhoneNumber(String phoneNumber) {
    return '${phoneNumber.substring(0, 5)}-${phoneNumber.substring(5, 10)}'; // Example: 12345-67890
  }

  /// Converts a numeric value from Firebase to a double
  static double firebaseNumberToDouble(num firebaseNumber) {
    return firebaseNumber.toDouble();
  }

  /// Converts a Firebase Timestamp to a DateTime object
  static DateTime timestampToDateTime(Timestamp timestamp) {
    return timestamp.toDate();
  }

  /// Calculates the total price based on hourly rate and the start and end times
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

  /// Converts a Firebase Timestamp to a formatted string in the format 'yyyy-MM-dd HH:mm aa'
  static String timestampToString(Timestamp timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm aa').format(timestamp.toDate());
  }

  /// Converts a Firebase Timestamp to a TimeOfDay object
  static TimeOfDay timestampToTimeOfDay(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  /// Converts a DateTime object to a Firebase Timestamp
  static Timestamp dateTimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }

  /// Converts a TimeOfDay object to a Firebase Timestamp with a fixed date
  static Timestamp timeOfDayToTimestamp(TimeOfDay timeOfDay) {
    return Timestamp.fromDate(
        DateTime(2002, 5, 22, timeOfDay.hour, timeOfDay.minute));
  }

  /// Converts a TimeOfDay object to a formatted string in the format 'hh:mm AM/PM'
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

  /// Parses a date string in the format 'yyyy-MM-dd HH:mm:ss' to a DateTime object
  static DateTime stringToDateTime(String dateString) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateString);
  }

  /// Parses a time string in the format 'HH:mm' to a TimeOfDay object
  static TimeOfDay stringToTimeOfDay(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
