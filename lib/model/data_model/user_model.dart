import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/formater.dart';

class UserModel {
  final String? id;
  final String name;
  final String number;
  final String email;
  final String profile;
  final bool isUser;

  // Updated constructor to accept id
  UserModel({
    this.id,
    required this.name,
    required this.number,
    required this.email,
    required this.profile,
    required this.isUser,
  });

  // Factory constructor to create UserModel from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"], // Assign id here
      name: json['name'],
      number: json['number'],
      email: json['email'],
      profile: json['profile'],
      isUser: json['isUser'],
    );
  }

  // Create an empty UserModel
  factory UserModel.emptyUserModel() {
    return UserModel(
      id: '', // Assign empty id here
      name: '',
      number: '',
      email: '',
      profile: '',
      isUser: false,
    );
  }

  // Convert UserModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Include id in the map
      'name': name,
      'number': number,
      'email': email,
      'profile': profile,
      'isUser': isUser,
    };
  }

  // Factory constructor to create UserModel from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      number: map['number'],
      email: map['email'],
      profile: map['profile'],
      isUser: map['isUser'],
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'email': email,
      'profile': profile,
      'isUser': isUser,
    };
  }

  // Factory constructor to create UserModel from JSON-like Map
  factory UserModel.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return UserModel(
      id: data['id'] ?? "N/A",
      name: data['name'] ?? "N/A",
      number: data['number'] ?? "N/A",
      email: data['email'],
      profile: data['profile'] ?? "N/A",
      isUser: data['isUser'] ?? "N/A",
    );
  }

  // Helper function to format phone number
  String get formattedPhoneNo => Formatter.formatPhoneNumber(number);

  // Static function to split full name into first and last name
  static List<String> nameParts(name) => name.split(' ');
}
