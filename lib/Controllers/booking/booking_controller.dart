import 'dart:convert';
import 'dart:developer';
import 'package:carapp/models/user_booking_data.dart';
import 'package:carapp/utils/api_contants.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BookingController extends GetxController {
  RxBool isLoading = false.obs;
  String? error;

  UserBookingData? userBookingData;

  List<BookingData>? get bookingData => userBookingData?.data ?? [];

  Future<void> fetchUserBookingData() async {
    isLoading.value = true;
    error = null;
    update();
    try {
      var response = await http.get(
        Uri.parse(
            "${ApiConstants.bookingHistoryEndPoint}/${SharedPrefs.getUserEmail}"),
        headers: {
          'Authorization': 'Bearer ${SharedPrefs.getToken}',
        },
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        userBookingData = UserBookingData.fromJson(data);
        log(response.body.toString());
      }
    } catch (e) {
      error = 'Error : $e';
      log(error.toString());
    }
    isLoading.value = false;
    update();
  }
}