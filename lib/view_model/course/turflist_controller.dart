import 'dart:developer';

import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/model/backend/repositories/firestore/activity_repositories.dart';

import '../../model/backend/repositories/firestore/turf_repositories.dart';
import '../../model/data_model/owner_model.dart';
import '../../model/data_model/user_activity_model.dart';

class TurflistController extends GetxController {
  final _turfList = <OwnerModel>[].obs;
  final _favouriteTurfList = ActivityModel.empty().obs;
  final _trendingTurfs = <String>[].obs;
  final _isLoading = true.obs;
  final _errorMessage = RxString('');
  final query = RxString('');
  final RxBool isLiked = false.obs;

  List<OwnerModel> get turfList => _turfList.toList();
  ActivityModel get favouriteTurfList => _favouriteTurfList.value;
  List<String> get trendingTurfs => _trendingTurfs;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();
    fetchTurfList();
  }

  Future<void> fetchTurfList() async {
    try {
      _isLoading.value = true;
      var turfList = await TurfRepository().fetchAllTurfDetails();
      _turfList.assignAll(turfList);
      var favourite = await ActivityRepository().fetchActivityDetails();
      var list = await ActivityRepository().findTrendingTurfs();
      _trendingTurfs.assignAll(list);
      _favouriteTurfList.value = favourite;
      _isLoading.value = false;
    } catch (e) {
      _errorMessage.value = 'Failed to fetch turf list: $e';
      log(e.toString());
      _isLoading.value = false;
    }
  }

  OwnerModel? viewTurf(String id) {
    try {
      if (turfList.isNotEmpty) {
        for (var turf in turfList) {
          if (turf.id == id) {
            return turf;
          }
        }
      }
      return null;
    } catch (e) {
      log("View turf error: $e");
      rethrow;
    }
  }

  Future<void> liked({required String turfId, required bool isFavorite}) async {
    await ActivityRepository().updateFavoriteTurf(turfId, isFavorite);
  }

  Future<void> checkIfLiked(String turfId) async {
    try {
      isLiked.value = await ActivityRepository().isFavoriteTurf(turfId);
      log("isLiked: ${isLiked.value}");
    } catch (e) {
      log("Error: checkIfLiked => $e");
    }
  }

  Future<void> searchTurf() async {
    try {
      if (query.isNotEmpty) {
        _isLoading.value = true;
        _errorMessage.value = '';
        var searchedTurfList = await TurfRepository().searchTurf(query.value);
        _turfList.assignAll(searchedTurfList);
        _isLoading.value = false;
        if (_turfList.isEmpty && query.isNotEmpty) {
          _errorMessage.value = 'Turf not found';
        }
      } else {
        _errorMessage.value = '';
        fetchTurfList();
      }
    } catch (e) {
      _errorMessage.value = 'Failed to search turf list: $e';
      _isLoading.value = false;
    }
  }
}
