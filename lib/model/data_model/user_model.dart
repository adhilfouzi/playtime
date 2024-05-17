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
  final List<OwnerModel> favourite;

  UserModel({
    this.id,
    required this.name,
    required this.number,
    required this.email,
    required this.profile,
    required this.isUser,
    required this.favourite,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<OwnerModel> favouritesList = [];
    if (json['favourite'] != null) {
      json['favourite'].forEach((v) {
        favouritesList.add(OwnerModel.fromJson(v));
      });
    }

    return UserModel(
      id: json["id"],
      name: json['name'],
      number: json['number'],
      email: json['email'],
      profile: json['profile'],
      isUser: json['isUser'],
      favourite: favouritesList,
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
      favourite: [],
    );
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> favouritesList =
        favourite.map((v) => v.toMap()).toList();

    return {
      'id': id,
      'name': name,
      'number': number,
      'email': email,
      'profile': profile,
      'isUser': isUser,
      'favourite': favouritesList,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    List<OwnerModel> favouritesList = [];
    if (map['favourite'] != null) {
      map['favourite'].forEach((v) {
        favouritesList.add(OwnerModel.fromMap(v));
      });
    }

    return UserModel(
      id: map['id'],
      name: map['name'],
      number: map['number'],
      email: map['email'],
      profile: map['profile'],
      isUser: map['isUser'],
      favourite: favouritesList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> favouritesList =
        favourite.map((v) => v.toJson()).toList();

    return {
      'id': id,
      'name': name,
      'number': number,
      'email': email,
      'profile': profile,
      'isUser': isUser,
      'favourite': favouritesList,
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
      favourite: favouritesList,
    );
  }

  String get formattedPhoneNo => Formatter.formatPhoneNumber(number);

  static List<String> nameParts(name) => name.split(' ');
}
