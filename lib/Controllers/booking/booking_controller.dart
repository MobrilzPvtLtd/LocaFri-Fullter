import 'dart:convert';
import 'dart:developer';
import 'package:carapp/models/user_booking_data_model.dart';
import 'package:carapp/utils/api_contants.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BookingController extends GetxController {
  RxBool isLoading = false.obs;
  String? error;

  UserBookingDataModel? userBookingData;

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
    isLoading.value = true;
    error = null;
    update();

    try {
      var url = Uri.parse(ApiConstants.bookingHistoryEndPoint);

      // Define the request body with the email
      var requestBody = jsonEncode({"email": SharedPrefs.getUserEmail});

      // Send a POST request
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',  // Set content type to JSON
        },
        body: requestBody,
      );

      // Log the response
      log(response.body.toString());

      // Check if the status code is 200 (success)
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        userBookingData = UserBookingDataModel.fromJson(data);
        log("Booking Data: ${response.body}");
      } else {
        error = 'Server Error: ${response.statusCode}';
        log(error.toString());
      }
    } catch (e) {
      error = 'Error: $e';
      log(error.toString());
    }

    isLoading.value = false;
    update();
  }

}
