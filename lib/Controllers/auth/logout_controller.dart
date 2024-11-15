import 'dart:convert';
import 'dart:developer';
import 'package:carapp/utils/api_contants.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:carapp/utils/shared_prefs_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LogoutController extends GetxController {
  RxBool isLoading = false.obs;
  String? error;

  Future<void> logout(BuildContext context) async {
    isLoading.value = true;
    error = null;
    try {
      var body = {
        "email": SharedPrefs.getUserEmail,
      };
      var response = await http.post(
        Uri.parse(ApiConstants.logoutEndPoint),
        headers: {"Authorization": "Bearer ${SharedPrefs.getToken}"},
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        SharedPrefs.resetValue(SharedPrefsKey.userFirstName);
        SharedPrefs.resetValue(SharedPrefsKey.userLastName);
        SharedPrefs.resetValue(SharedPrefsKey.userPhoneNumber);
        SharedPrefs.resetValue(SharedPrefsKey.userEmail);
        SharedPrefs.resetValue(SharedPrefsKey.token);
        Navigator.pop(context);
        Get.snackbar("Success", "Log Out");
        log(response.body.toString());
      } else {
        Get.snackbar("Failed", "Something went wrong");
      }
    } catch (e) {
      error = e.toString();
      log("Error : $e");
    }
    isLoading.value = false;
  }
}
