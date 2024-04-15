import '../controller/formater.dart';

class UserModel {
  final String name;
  final String number;
  final String email;
  final String password;
  final String profile;
  final bool isUser;

  UserModel({
    required this.name,
    required this.number,
    required this.email,
    required this.password,
    required this.profile,
    required this.isUser,
  });

  // Factory constructor to create UserModel from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      number: json['number'],
      email: json['email'],
      password: json['password'],
      profile: json['profile'],
      isUser: json['isUser'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'email': email,
      'password': password,
      'profile': profile,
      'isUser': isUser,
    };
  }

  // helper function to fotmat phone number
  String get formattedPhoneNo => Formatter.formatPhoneNumber(number);
  // static function to split full name into first and last name
  static List<String> nameParts(name) => name.split('');
}
