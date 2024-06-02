import 'dart:developer';

import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/view_model/course/ads_controller.dart';

import '../../model/backend/repositories/firestore/activity_repositories.dart';
import '../../model/backend/repositories/firestore/booking_repositories.dart';
import '../../model/backend/repositories/firestore/turf_repositories.dart';
import '../../model/data_model/booking_model.dart';
import '../../model/data_model/owner_model.dart';
import '../../model/data_model/user_activity_model.dart';

class TurfController extends GetxController {
  RxList<BookingModel> activeBookings = <BookingModel>[].obs;
  RxList<BookingModel> canceledBookings = <BookingModel>[].obs;
  RxList<BookingModel> completedBookings = <BookingModel>[].obs;
  final _isLoadingBookings = false.obs;
  final _errorMessageBookings = RxString('');

  // TurflistController variables
  final _turfList = <OwnerModel>[].obs;
  final _favouriteTurfList = ActivityModel.empty().obs;
  final _trendingTurfs = <String>[].obs;
  final _isLoadingTurfs = false.obs;
  final _isLoadingHome = false.obs;
  final _errorMessageTurfs = RxString('');
  final _errorMessageHome = RxString('');
  final query = RxString('');
  final RxBool isLiked = false.obs;

  // Getters for TurfController variables
  bool get isLoadingBookings => _isLoadingBookings.value;
  String get errorMessageBookings => _errorMessageBookings.value;

  // Getters for TurflistController variables
  List<OwnerModel> get turfList => _turfList.toList();
  ActivityModel get favouriteTurfList => _favouriteTurfList.value;
  List<String> get trendingTurfs => _trendingTurfs;
  bool get isLoadingTurfs => _isLoadingTurfs.value;
  bool get isLoadingHome => _isLoadingHome.value;
  String get errorMessageTurfs => _errorMessageTurfs.value;
  String get errorMessageHome => _errorMessageHome.value;

  @override
  void onInit() {
    super.onInit();
    separateBookings();
    fetchTurfList();
  }

  Future<void> separateBookings() async {
    try {
      _errorMessageBookings.value = '';
      _isLoadingBookings.value = true;
      activeBookings.clear();
      canceledBookings.clear();
      completedBookings.clear();

      List<BookingModel> bookings =
          await BookingRepository().fetchAllBookingDetails();
      DateTime currentTime = DateTime.now();

      for (var booking in bookings) {
        if (booking.status == 'approved' &&
            booking.startTime.isBefore(currentTime)) {
          completedBookings.add(booking);
        } else if (booking.status == 'canceled' ||
            booking.endTime.isBefore(currentTime)) {
          canceledBookings.add(booking);
        } else if (booking.endTime.isAfter(currentTime) &&
            (booking.status == 'pending' || booking.status == 'approved')) {
          activeBookings.add(booking);
        }
      }

      log("Active Bookings: ${activeBookings.length}");
      log("Canceled Bookings: ${canceledBookings.length}");
      log("Completed Bookings: ${completedBookings.length}");
    } catch (e) {
      _errorMessageBookings.value = 'Error: $e';
    } finally {
      _isLoadingBookings.value = false; // Update loading state to false
      update(); // Trigger state update
    }
  }

  Future<void> fetchTurfList() async {
    try {
      _errorMessageTurfs.value = '';
      _isLoadingTurfs.value = true;
      log("fetch Turf List loading........");
      var turfList = await TurfRepository().fetchAllTurfDetails();
      _turfList.assignAll(turfList);
      var favourite = await ActivityRepository().fetchActivityDetails();
      var list = await ActivityRepository().findTrendingTurfs();
      _trendingTurfs.assignAll(list);
      _favouriteTurfList.value = favourite;
    } catch (e) {
      _errorMessageTurfs.value = 'Failed to fetch turf list: $e';
      log(e.toString());
    } finally {
      _isLoadingTurfs.value = false;
      log("fetch Turf List loading........end ");
    }
  }

  Future<void> refreshHomescreen() async {
    _isLoadingHome.value = true;
    try {
      var favourite = await ActivityRepository().fetchActivityDetails();
      AdsController().fetchAds();
      var list = await ActivityRepository().findTrendingTurfs();
      _trendingTurfs.assignAll(list);
      _favouriteTurfList.value = favourite;
    } catch (e) {
      _errorMessageHome.value = 'Loading Error';
      log(e.toString());
    } finally {
      _isLoadingHome.value = false;
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
        _isLoadingTurfs.value = true;
        _errorMessageTurfs.value = '';
        var searchedTurfList = await TurfRepository().searchTurf(query.value);
        _turfList.assignAll(searchedTurfList);
        _isLoadingTurfs.value = false;
        if (_turfList.isEmpty && query.isNotEmpty) {
          _errorMessageTurfs.value = 'Turf not found';
        }
      } else {
        _errorMessageTurfs.value = '';
        fetchTurfList();
      }
    } catch (e) {
      _errorMessageTurfs.value = 'Failed to search turf list: $e';
      _isLoadingTurfs.value = false;
    }
  }
}
