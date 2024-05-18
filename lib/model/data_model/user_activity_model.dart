import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  List<String> favourite;

  ActivityModel({
    required this.favourite,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    List<String> favourite = [];
    if (json['favourite'] != null && json['favourite'] is List) {
      favourite = List<String>.from(json['favourite']);
    }

    return ActivityModel(
      favourite: favourite,
    );
  }

  factory ActivityModel.empty() {
    return ActivityModel(
      favourite: [],
    );
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    List<String> favourite = [];
    if (map['favourite'] != null && map['favourite'] is List) {
      favourite = List<String>.from(map['favourite']);
    }

    return ActivityModel(
      favourite: favourite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favourite': favourite,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'favourite': favourite,
    };
  }

  factory ActivityModel.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    List<String> favourite = [];
    if (data['favourite'] != null && data['favourite'] is List) {
      favourite = List<String>.from(data['favourite']);
    }

    return ActivityModel(
      favourite: favourite,
    );
  }
}
