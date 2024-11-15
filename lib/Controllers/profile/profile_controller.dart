import 'dart:convert';
import 'dart:developer';
import 'package:carapp/utils/api_contants.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  String? error;

  Future<void> updateProfile(String fisrtName, String lastName, String email,
      String phoneNumber, BuildContext context) async {
    isLoading.value = true;
    error = null;
    update();
    try {
      var body = {
        "first_name": fisrtName,
        "last_name": lastName,
        "email": email,
        "mobile": phoneNumber
      };
      var response = await http.put(
        Uri.parse(ApiConstants.updateProfileEndPoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${SharedPrefs.getToken}"
        },
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        SharedPrefs.setUserFirstName(fisrtName);
        SharedPrefs.setUserLastName(lastName);
        SharedPrefs.setUserEmail(email);
        SharedPrefs.setUserPhoneNumber(phoneNumber);
        Navigator.pop(context);
        Get.snackbar("Success", "Profile Detail Updated");
        log(response.body.toString());
      } else {
        Get.snackbar("Failed", "Something went wrong");
      }
    } catch (e) {
      error = 'Error : $e';
      log(error.toString());
    }
    isLoading.value = false;
    update();
  }
}
