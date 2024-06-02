import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/formater.dart';

/// Model class representing a transaction.
class TransactionModel {
  final String? id;
  final String bookingId;
  final String userId;
  final String username;
  final String userEmail;
  final String userNumber;
  final double amount;
  final DateTime transactionDate;
  final String status;
  final String paymentMethod;

  /// Constructor for TransactionModel.
  TransactionModel({
    this.id,
    required this.bookingId,
    required this.userId,
    required this.username,
    required this.userEmail,
    required this.userNumber,
    required this.amount,
    required this.transactionDate,
    required this.status,
    required this.paymentMethod,
  });

  /// Factory method to create a TransactionModel instance from JSON data.
  factory TransactionModel.fromJson(Map<String, dynamic> json, String id) {
    return TransactionModel(
      id: id,
      bookingId: json['bookingId'] ?? "N/A",
      userId: json['userId'] ?? "N/A",
      username: json['username'] ?? "N/A",
      userEmail: json['userEmail'] ?? "N/A",
      userNumber: json['userNumber'] ?? "N/A",
      amount: Formatter.firebaseNumberToDouble(json['amount']),
      transactionDate: Formatter.timestampToDateTime(json['transactionDate']),
      status: json['status'] ?? "N/A",
      paymentMethod: json['paymentMethod'] ?? "N/A",
    );
  }

  /// Factory method to create a TransactionModel instance from a document snapshot.
  factory TransactionModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return TransactionModel(
      id: snapshot.id,
      bookingId: data['bookingId'] ?? "N/A",
      userId: data['userId'] ?? "N/A",
      username: data['username'] ?? "N/A",
      userEmail: data['userEmail'] ?? "N/A",
      userNumber: data['userNumber'] ?? "N/A",
      amount: Formatter.firebaseNumberToDouble(data['amount']),
      transactionDate: Formatter.timestampToDateTime(data['transactionDate']),
      status: data['status'] ?? "N/A",
      paymentMethod: data['paymentMethod'] ?? "N/A",
    );
  }

  /// Convert the TransactionModel instance to JSON format.
  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'userId': userId,
      'username': username,
      'userEmail': userEmail,
      'userNumber': userNumber,
      'amount': amount,
      'transactionDate': Formatter.dateTimeToTimestamp(transactionDate),
      'status': status,
      'paymentMethod': paymentMethod,
    };
  }
}

/// Enumeration representing transaction status.
enum TransactionStatus { pending, completed, failed }

/// Extension for TransactionStatus enum.
extension TransactionStatusExtension on TransactionStatus {
  String get value {
    switch (this) {
      case TransactionStatus.pending:
        return 'pending';
      case TransactionStatus.completed:
        return 'completed';
      case TransactionStatus.failed:
        return 'failed';
    }
  }
}

/// Enumeration representing payment method.
enum PaymentMethod { cash, online, failed }

/// Extension for PaymentMethod enum.
extension PaymentMethodExtension on PaymentMethod {
  String get value {
    switch (this) {
      case PaymentMethod.cash:
        return 'cash';
      case PaymentMethod.online:
        return 'online';
      case PaymentMethod.failed:
        return 'failed';
    }
  }
}
