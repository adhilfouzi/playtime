import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/formater.dart';
import 'owner_model.dart';

class BookingModel {
  final String? id;
  final OwnerModel turf;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final String status;
  final double price;
  final String username;
  final String userEmail;
  final String userNumber;

  BookingModel({
    this.id,
    required this.turf,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.price,
    required this.username,
    required this.userEmail,
    required this.userNumber,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json, String id) {
    var end = Formatter.timestampToDateTime(json['endTime']);
    var start = Formatter.timestampToDateTime(json['startTime']);
    return BookingModel(
      id: id,
      turf: OwnerModel.fromJson(json['turf'] ?? {}),
      userId: json['userId'] ?? "N/A",
      startTime: start,
      endTime: end,
      status: json['status'] ?? "N/A",
      price: Formatter.firebaseNumberToDouble(json['price']),
      username: json['username'] ?? "N/A",
      userEmail: json['userEmail'] ?? "N/A",
      userNumber: json['userNumber'] ?? "N/A",
    );
  }

  factory BookingModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    var start = Formatter.timestampToDateTime(data['startTime']);
    var end = Formatter.timestampToDateTime(data['endTime']);
    return BookingModel(
      turf: OwnerModel.fromJson(data['turf'] ?? {}),
      userId: data['userId'] ?? "N/A",
      startTime: start,
      endTime: end,
      status: data['status'] ?? "N/A",
      price: Formatter.firebaseNumberToDouble(data['price']),
      username: data['username'] ?? "N/A",
      userEmail: data['userEmail'] ?? "N/A",
      userNumber: data['userNumber'] ?? "N/A",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'turf': turf.toJson(),
      'userId': userId,
      'startTime': Formatter.dateTimeToTimestamp(startTime),
      'endTime': Formatter.dateTimeToTimestamp(endTime),
      'status': status,
      'price': price,
      'username': username,
      'userEmail': userEmail,
      'userNumber': userNumber,
    };
  }
}

enum Status { pending, approved, canceled }

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
