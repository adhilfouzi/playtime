import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  // final String id;
  final String turfId;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final String status;
  final String username;
  final String userEmail;
  final String userNumber;

  BookingModel({
    // required this.id,
    required this.turfId,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.username,
    required this.userEmail,
    required this.userNumber,
  });

  factory BookingModel.emptyBookingModel() {
    return BookingModel(
      // id: "N/A",
      turfId: "N/A",
      userId: "N/A",
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      status: "N/A",
      username: "N/A",
      userEmail: "N/A",
      userNumber: "N/A",
    );
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      // id: json['id'] ?? "N/A",
      turfId: json['turfId'] ?? "N/A",
      userId: json['userId'] ?? "N/A",
      startTime: DateTime.parse(json['startTime'] ?? ''),
      endTime: DateTime.parse(json['endTime'] ?? ''),
      status: json['status'] ?? "N/A",
      username: json['username'] ?? "N/A",
      userEmail: json['userEmail'] ?? "N/A",
      userNumber: json['userNumber'] ?? "N/A",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'turfId': turfId,
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'status': status,
      'username': username,
      'userEmail': userEmail,
      'userNumber': userNumber,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      // id: map['id'] ?? "N/A",
      turfId: map['turfId'] ?? "N/A",
      userId: map['userId'] ?? "N/A",
      startTime: DateTime.parse(map['startTime'] ?? ''),
      endTime: DateTime.parse(map['endTime'] ?? ''),
      status: map['status'] ?? "N/A",
      username: map['username'] ?? "N/A",
      userEmail: map['userEmail'] ?? "N/A",
      userNumber: map['userNumber'] ?? "N/A",
    );
  }

  factory BookingModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return BookingModel(
      // id: data['id'] ?? "N/A",
      turfId: data['turfId'] ?? "N/A",
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
