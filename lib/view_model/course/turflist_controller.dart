import 'dart:developer';

import 'package:get/get.dart';

import '../../model/backend/repositories/firestore/turf_repositories.dart';
import '../../model/data_model/owner_model.dart';

class TurflistController extends GetxController {
  final _turfList = <OwnerModel>[].obs;
  final _isLoading = true.obs;
  final _errorMessage = RxString('');
  final query = RxString('');

  List<OwnerModel> get turfList => _turfList.toList();
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
      _isLoading.value = false;
    } catch (e) {
      _errorMessage.value = 'Failed to fetch turf list: $e';
      log(e.toString());
      _isLoading.value = false;
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
