import 'owner_model.dart';

class ActivityModel {
  List<OwnerModel> favourite;

  ActivityModel({
    required this.favourite,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    List<OwnerModel> favourite = [];
    if (json['favourite'] != null && json['favourite'] is List) {
      favourite = List<OwnerModel>.from(
          json['favourite'].map((item) => OwnerModel.fromJson(item)));
    }

    return ActivityModel(
      favourite: favourite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favourite': favourite.map((owner) => owner.toJson()).toList(),
    };
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    List<OwnerModel> favourite = [];
    if (map['favourite'] != null && map['favourite'] is List) {
      favourite = List<OwnerModel>.from(
          map['favourite'].map((item) => OwnerModel.fromMap(item)));
    }

    return ActivityModel(
      favourite: favourite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'favourite': favourite.map((owner) => owner.toMap()).toList(),
    };
  }
}
