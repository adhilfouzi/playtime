import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    final formatCurrency = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    return formatCurrency.format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Assuming the phone number format is 10 digits
    return '${phoneNumber.substring(0, 5)}-${phoneNumber.substring(5, 10)}'; // Example: 12345-67890
  }

  static DateTime timestampToDateTime(Timestamp timestamp) {
    return timestamp.toDate();
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
    return '${timeOfDay.hour}:${timeOfDay.minute}';
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
