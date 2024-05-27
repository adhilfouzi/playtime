import 'package:cloud_firestore/cloud_firestore.dart';

class AdsModel {
  List<String> poster;

  AdsModel({
    required this.poster,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    List<String> poster = [];
    if (json['poster'] != null && json['poster'] is List) {
      poster = List<String>.from(json['poster']);
    }

    return AdsModel(
      poster: poster,
    );
  }

  factory AdsModel.empty() {
    return AdsModel(
      poster: [],
    );
  }

  factory AdsModel.fromMap(Map<String, dynamic> map) {
    List<String> poster = [];
    if (map['poster'] != null && map['poster'] is List) {
      poster = List<String>.from(map['poster']);
    }

    return AdsModel(
      poster: poster,
    );
  }
  factory AdsModel.emptyAdsModel() {
    return AdsModel(poster: []);
  }

  Map<String, dynamic> toJson() {
    return {
      'poster': poster,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'poster': poster,
    };
  }

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
