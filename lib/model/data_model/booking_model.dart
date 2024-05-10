import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:users_side_of_turf_booking/model/data_model/owner_model.dart';

class BookingModel {
  final OwnerModel turf;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final String status;
  final String username;
  final String userEmail;
  final String userNumber;

  BookingModel({
    required this.turf,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.username,
    required this.userEmail,
    required this.userNumber,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      turf: OwnerModel.fromJson(json['turf'] ?? {}),
      userId: json['userId'] ?? "N/A",
      startTime: DateTime.parse(json['startTime'] ?? ''),
      endTime: DateTime.parse(json['endTime'] ?? ''),
      status: json['status'] ?? "N/A",
      username: json['username'] ?? "N/A",
      userEmail: json['userEmail'] ?? "N/A",
      userNumber: json['userNumber'] ?? "N/A",
    );
  }

  factory BookingModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return BookingModel(
      turf: OwnerModel.fromJson(data['turf'] ?? {}),
      userId: data['userId'] ?? "N/A",
      startTime: data['startTime'] != null
          ? DateTime.parse(data['startTime'])
          : DateTime.now(),
      endTime: data['endTime'] != null
          ? DateTime.parse(data['endTime'])
          : DateTime.now(),
      status: data['status'] ?? "N/A",
      username: data['username'] ?? "N/A",
      userEmail: data['userEmail'] ?? "N/A",
      userNumber: data['userNumber'] ?? "N/A",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'turf': turf.toJson(),
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'status': status,
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
