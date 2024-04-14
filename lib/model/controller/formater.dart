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
}
