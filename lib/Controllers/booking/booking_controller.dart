import 'dart:convert';
import 'dart:developer';
import 'package:carapp/models/user_booking_data_model.dart';
import 'package:carapp/utils/api_contants.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BookingController extends GetxController {
  UserBookingDataModel? userBookingData;
  var isLoading = true.obs;
  var error = Rxn<String>(); // Nullable String
  List<Data>? get bookingData => userBookingData?.data ?? [];

  // Future<void> fetchUserBookingData() async {
  //   isLoading.value = true;
  //   error = null;
  //   update();
  //   try {
  //     var response = await http.get(Uri.parse(
  //         "${ApiConstants.bookingHistoryEndPoint}/${SharedPrefs.getUserEmail}"));
  //     log(response.body.toString());
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       userBookingData = UserBookingDataModel.fromJson(data);
  //       log(response.body.toString());
  //     }
  //   } catch (e) {
  //     error = 'Error : $e';
  //     log(error.toString());
  //   }
  //   isLoading.value = false;
  //   update();
  // }
  Future<void> fetchUserBookingData() async {
    try {
      isLoading.value = true; // Start loading
      error.value = null; // Reset previous error
      var url = Uri.parse(ApiConstants.bookingHistoryEndPoint);
      var requestBody = jsonEncode({"email": SharedPrefs.getUserEmail});

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        userBookingData = UserBookingDataModel.fromJson(data);
      } else {
        error.value = 'Server Error: ${response.statusCode}';
      }
    } catch (e) {
      error.value = 'Error: $e'; // Capture exception
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
