import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class representing user activity.
class ActivityModel {
  List<String> favourite;

  /// Constructor for ActivityModel.
  ActivityModel({
    required this.favourite,
  });

  /// Factory method to create an ActivityModel instance from JSON data.
  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    List<String> favourite = [];
    if (json['favourite'] != null && json['favourite'] is List) {
      favourite = List<String>.from(json['favourite']);
    }

    return ActivityModel(
      favourite: favourite,
    );
  }

  /// Factory method to create an empty ActivityModel instance.
  factory ActivityModel.empty() {
    return ActivityModel(
      favourite: [],
    );
  }

  /// Factory method to create an ActivityModel instance from a map.
  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    List<String> favourite = [];
    if (map['favourite'] != null && map['favourite'] is List) {
      favourite = List<String>.from(map['favourite']);
    }

    return ActivityModel(
      favourite: favourite,
    );
  }

  /// Convert the ActivityModel instance to JSON format.
  Map<String, dynamic> toJson() {
    return {
      'favourite': favourite,
    };
  }

  /// Convert the ActivityModel instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'favourite': favourite,
    };
  }

  /// Factory method to create an ActivityModel instance from a document snapshot.
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
