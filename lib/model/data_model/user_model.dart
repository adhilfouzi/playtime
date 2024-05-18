import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:users_side_of_turf_booking/model/data_model/owner_model.dart';

import '../controller/formater.dart';

class UserModel {
  final String? id;
  final String name;
  final String number;
  final String email;
  final String profile;
  final bool isUser;

  UserModel({
    this.id,
    required this.name,
    required this.number,
    required this.email,
    required this.profile,
    required this.isUser,
  });

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

  factory UserModel.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    List<OwnerModel> favouritesList = [];
    if (data['favourite'] != null) {
      data['favourite'].forEach((v) {
        favouritesList.add(OwnerModel.fromJson(v));
      });
    }

    return UserModel(
      id: data['id'] ?? "N/A",
      name: data['name'] ?? "N/A",
      number: data['number'] ?? "N/A",
      email: data['email'] ?? "N/A",
      profile: data['profile'] ?? "N/A",
      isUser: data['isUser'] ?? "N/A",
    );
  }

  String get formattedPhoneNo => Formatter.formatPhoneNumber(number);

  static List<String> nameParts(name) => name.split(' ');
}
