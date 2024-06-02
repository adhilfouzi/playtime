import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class for representing ads data.
class AdsModel {
  /// List of poster URLs.
  List<String> poster;

  /// Constructor for AdsModel.
  AdsModel({
    required this.poster,
  });

  /// Factory method to create an AdsModel instance from JSON data.
  factory AdsModel.fromJson(Map<String, dynamic> json) {
    List<String> poster = [];
    if (json['poster'] != null && json['poster'] is List) {
      poster = List<String>.from(json['poster']);
    }

    return AdsModel(
      poster: poster,
    );
  }

  /// Factory method to create an empty AdsModel instance.
  factory AdsModel.empty() {
    return AdsModel(
      poster: [],
    );
  }

  /// Factory method to create an AdsModel instance from a map.
  factory AdsModel.fromMap(Map<String, dynamic> map) {
    List<String> poster = [];
    if (map['poster'] != null && map['poster'] is List) {
      poster = List<String>.from(map['poster']);
    }

    return AdsModel(
      poster: poster,
    );
  }

  /// Factory method to create an empty AdsModel instance.
  factory AdsModel.emptyAdsModel() {
    return AdsModel(poster: []);
  }

  /// Convert the AdsModel instance to JSON format.
  Map<String, dynamic> toJson() {
    return {
      'poster': poster,
    };
  }

  /// Convert the AdsModel instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'poster': poster,
    };
  }

  /// Factory method to create an AdsModel instance from a Firestore document snapshot.
  factory AdsModel.fromSnapshot(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    List<String> poster = [];
    if (data['poster'] != null && data['poster'] is List) {
      poster = List<String>.from(data['poster']);
    }

    return AdsModel(
      poster: poster,
    );
  }
}
