import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller/formater.dart';

/// Model class representing a user.
class UserModel {
  final String? id;
  final String name;
  final String number;
  final String email;
  final String profile;
  final bool isUser;

  /// Constructor for UserModel.
  UserModel({
    this.id,
    required this.name,
    required this.number,
    required this.email,
    required this.profile,
    required this.isUser,
  });

  /// Factory method to create a UserModel instance from JSON data.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json['name'],
      number: json['number'],
      email: json['email'],
      profile: json['profile'],
      isUser: json['isUser'],
    );
  }

  /// Factory method to create an empty UserModel instance.
  factory UserModel.emptyUserModel() {
    return UserModel(
      id: '',
      name: '',
      number: '',
      email: '',
      profile: '',
      isUser: false,
    );
  }

  /// Convert the UserModel instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'email': email,
      'profile': profile,
      'isUser': isUser,
    };
  }

  /// Factory method to create a UserModel instance from a map.
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

  /// Convert the UserModel instance to JSON format.
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

  /// Factory method to create a UserModel instance from a document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return UserModel(
      id: data['id'] ?? "N/A",
      name: data['name'] ?? "N/A",
      number: data['number'] ?? "N/A",
      email: data['email'] ?? "N/A",
      profile: data['profile'] ?? "N/A",
      isUser: data['isUser'] ?? "N/A",
    );
  }

  /// Get formatted phone number.
  String get formattedPhoneNo => Formatter.formatPhoneNumber(number);

  /// Split name into parts.
  static List<String> nameParts(String name) => name.split(' ');
}
