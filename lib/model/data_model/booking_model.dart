import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/formater.dart';
import 'owner_model.dart';

/// Model class for representing booking data.
class BookingModel {
  final String? id;
  final OwnerModel turf;
  final String userId;
  final String userProfile;
  final String username;
  final String userEmail;
  final String userNumber;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime bookedDate;
  final String status;
  final double price;
  final double paid;
  final double balance;
  final double discount;

  /// Constructor for BookingModel.
  BookingModel({
    this.id,
    required this.turf,
    required this.userId,
    required this.userProfile,
    required this.username,
    required this.userEmail,
    required this.userNumber,
    required this.startTime,
    required this.endTime,
    required this.bookedDate,
    required this.status,
    required this.price,
    required this.paid,
    required this.balance,
    required this.discount,
  });

  /// Factory method to create a BookingModel instance from JSON data.
  factory BookingModel.fromJson(Map<String, dynamic> json, String id) {
    return BookingModel(
      id: id,
      turf: OwnerModel.fromJson(json['turf'] ?? {}),
      userId: json['userId'] ?? "N/A",
      userProfile: json['userProfile'] ?? "N/A",
      username: json['username'] ?? "N/A",
      userEmail: json['userEmail'] ?? "N/A",
      userNumber: json['userNumber'] ?? "N/A",
      startTime: Formatter.timestampToDateTime(json['startTime']),
      endTime: Formatter.timestampToDateTime(json['endTime']),
      bookedDate: Formatter.timestampToDateTime(json['bookedDate']),
      status: json['status'] ?? "N/A",
      price: Formatter.firebaseNumberToDouble(json['price']),
      paid: Formatter.firebaseNumberToDouble(json['paid']),
      balance: Formatter.firebaseNumberToDouble(json['balance']),
      discount: Formatter.firebaseNumberToDouble(json['discount']),
    );
  }

  /// Factory method to create a BookingModel instance from a Firestore document snapshot.
  factory BookingModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return BookingModel(
      id: snapshot.id,
      turf: OwnerModel.fromJson(data['turf'] ?? {}),
      userId: data['userId'] ?? "N/A",
      userProfile: data['userProfile'] ?? "N/A",
      username: data['username'] ?? "N/A",
      userEmail: data['userEmail'] ?? "N/A",
      userNumber: data['userNumber'] ?? "N/A",
      startTime: Formatter.timestampToDateTime(data['startTime']),
      endTime: Formatter.timestampToDateTime(data['endTime']),
      bookedDate: Formatter.timestampToDateTime(data['bookedDate']),
      status: data['status'] ?? "N/A",
      price: Formatter.firebaseNumberToDouble(data['price']),
      paid: Formatter.firebaseNumberToDouble(data['paid']),
      balance: Formatter.firebaseNumberToDouble(data['balance']),
      discount: Formatter.firebaseNumberToDouble(data['discount']),
    );
  }

  /// Convert the BookingModel instance to JSON format.
  Map<String, dynamic> toJson() {
    return {
      'turf': turf.toJson(),
      'userId': userId,
      'userProfile': userProfile,
      'username': username,
      'userEmail': userEmail,
      'userNumber': userNumber,
      'startTime': Formatter.dateTimeToTimestamp(startTime),
      'endTime': Formatter.dateTimeToTimestamp(endTime),
      'bookedDate': Formatter.dateTimeToTimestamp(bookedDate),
      'status': status,
      'price': price,
      'paid': paid,
      'balance': balance,
      'discount': discount,
    };
  }
}

/// Enumeration for booking status.
enum Status { pending, approved, canceled }

/// Extension on Status enum to get string value.
extension StatusExtension on Status {
  String get value {
    switch (this) {
      case Status.pending:
        return 'pending';
      case Status.approved:
        return 'approved';
      case Status.canceled:
        return 'canceled';
    }
  }
}
