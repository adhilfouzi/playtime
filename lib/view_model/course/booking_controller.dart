import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/model/backend/repositories/authentication/firebase_authentication.dart';
import 'package:users_side_of_turf_booking/model/backend/repositories/firestore/booking_repositories.dart';
import 'package:users_side_of_turf_booking/model/data_model/owner_model.dart';
import 'package:users_side_of_turf_booking/utils/portion/loadingpopup.dart';
import 'package:users_side_of_turf_booking/utils/portion/snackbar.dart';
import 'package:users_side_of_turf_booking/view/course/head/bottom_navigationbar_widget.dart';

import '../../model/data_model/booking_model.dart';
import '../../view/course/mybooking/screens/booking/booking_form_two.dart';
import 'usermodel_controller.dart';

class BookingController extends GetxController {
  final bookedSlot = <DateTime>[].obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<TimeOfDay> startTime = Rx<TimeOfDay>(const TimeOfDay(hour: 0, minute: 0));
  Rx<TimeOfDay> endTime = Rx<TimeOfDay>(const TimeOfDay(hour: 0, minute: 0));
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var price = 0.0.obs;
  var turf = OwnerModel.emptyOwnerModel().obs();

  UserController userController = Get.find();

  @override
  void onInit() {
    super.onInit();
    name.text = userController.user.value.name;
    email.text = userController.user.value.email;
    phone.text = userController.user.value.number;
  }

  // Method to combine date and time
  DateTime combineDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void bookTheturf() async {
    Get.to(() => const LoadingPopup());
    try {
      var booking = BookingModel(
          turf: turf,
          userId: AuthenticationRepository().authUser!.uid,
          startTime: combineDateTime(selectedDate.value, startTime.value),
          endTime: combineDateTime(selectedDate.value, endTime.value),
          status: Status.pending.value,
          price: price.value,
          username: name.text,
          userEmail: email.text,
          userNumber: phone.text);

      await BookingRepository().saveBookingRecord(booking, turf.id);
      Get.offAll(() => const MyBottomNavigationBar());
      CustomSnackbar.showSuccess("Booking completed");
    } catch (e) {
      CustomSnackbar.showError(e.toString());
    }
  }

  void nextWay() {
    if (startTime.value == endTime.value) {
      CustomSnackbar.showError("Please select a time to play");
      log("message");
      return;
    } else {
      Get.to(() => BookingFormTwo());
    }
  }

  void bookedSlots() async {
    final booked =
        await BookingRepository().fetchTurfBooking(turf.id, selectedDate.value);
    log("Booked slot length: ${booked.length}");
    bookedSlot.assignAll(booked);
  }
}
