import '../controller/formater.dart';

class UserModel {
  final String name;
  final String number;
  final String email;
  final String password;
  final String profile;

  UserModel({
    required this.name,
    required this.number,
    required this.email,
    required this.password,
    required this.profile,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'email': email,
      'password': password,
      'profile': profile,
    };
  }

  // helper function to fotmat phone number
  String get formattedPhoneNo => Formatter.formatPhoneNumber(number);
  // static function to split full name into first and last name
  static List<String> nameParts(name) => name.split('');
}
