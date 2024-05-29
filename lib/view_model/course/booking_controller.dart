import 'dart:developer';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/model/backend/repositories/authentication/firebase_authentication.dart';
import 'package:users_side_of_turf_booking/model/backend/repositories/firestore/booking_repositories.dart';
import 'package:users_side_of_turf_booking/model/data_model/owner_model.dart';
import 'package:users_side_of_turf_booking/model/data_model/transaction_model.dart';
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
  var turf = OwnerModel.emptyOwnerModel().obs;
  late Razorpay _razorpay;

  UserController userController = Get.find();

  @override
  void onInit() {
    super.onInit();
    name.text = userController.user.value.name;
    email.text = userController.user.value.email;
    phone.text = userController.user.value.number;

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  // Method to combine date and time
  DateTime combineDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void bookTheTurf() async {
    final advance = price.value ~/ 2;
    var options = {
      'key': 'rzp_test_X95zcCjqK3bbAQ', // Replace with your Razorpay key
      'amount': (advance * 100).toInt(), // Amount in paise
      'name': name.text,
      'description': 'Turf Booking Payment',
      'prefill': {
        'contact': phone.text,
        'email': email.text,
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      log(e.toString());
      CustomSnackbar.showError('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      final advance = price.value ~/ 2;
      final userId = AuthenticationRepository().authUser!.uid;

      var booking = BookingModel(
          turf: turf.value,
          userId: userId,
          startTime: combineDateTime(selectedDate.value, startTime.value),
          endTime: combineDateTime(selectedDate.value, endTime.value),
          status: Status.approved.value,
          price: price.value,
          balance: advance.toDouble(),
          bookedDate: DateTime.now(),
          discount: 0,
          userProfile: userController.user.value.profile,
          paid: advance.toDouble(),
          username: name.text,
          userEmail: email.text,
          userNumber: phone.text);

      var bookingId =
          await BookingRepository().saveBookingRecord(booking, turf.value.id);

      var transaction = TransactionModel(
          bookingId: bookingId,
          userId: userId,
          username: name.text,
          userEmail: email.text,
          userNumber: phone.text,
          amount: advance.toDouble(),
          transactionDate: DateTime.now(),
          status: TransactionStatus.completed.value,
          paymentMethod: PaymentMethod.online.value);

      await BookingRepository()
          .saveTransactionRecord(transaction, turf.value.id);

      Get.offAll(() => const MyBottomNavigationBar());
      CustomSnackbar.showSuccess("Booking completed");
    } catch (e) {
      CustomSnackbar.showError(e.toString());
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    CustomSnackbar.showError('Payment failed: ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    CustomSnackbar.showInfo('External Wallet selected: ${response.walletName}');
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
    final booked = await BookingRepository()
        .fetchTurfBooking(turf.value.id, selectedDate.value);
    log("Booked slot length: ${booked.length}");
    bookedSlot.assignAll(booked);
  }
}
