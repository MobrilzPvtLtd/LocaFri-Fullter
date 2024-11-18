import 'dart:convert';
import 'dart:developer';
import 'package:carapp/utils/api_contants.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:carapp/widget/bottomnavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  String? error;
  var verifyOtpStatus = false.obs;
  var otp = ''.obs;

  void updateVerifyOtpStatus(bool value) {
    verifyOtpStatus.value = value;
  }

  void updateOtp(String value) {
    otp.value = value;
  }

  void verifyEmail(String? email, BuildContext context) {
    if (email != null) {
      fetchOTP(email);
      _verifyEmailDailogBox(email, context);
    }
  }

  Future<void> fetchOTP(String email) async {
    try {
      var body = {"email": email};
      var response = await http.post(
        Uri.parse(ApiConstants.loginEndPoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        log(responseData.toString());
      }
    } catch (e) {
      log("Error : $e");
    }
  }

  void _verifyEmailDailogBox(String email, BuildContext context) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return CupertinoAlertDialog(
              title: const Text('Verify Email'),
              content: Column(
                children: [
                  const SizedBox(height: 10),
                  Text('OTP has been sent to $email'),
                  const SizedBox(height: 20),
                  CupertinoTextField(
                    onChanged: updateOtp,
                    placeholder: 'Enter OTP',
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CupertinoColors.systemGrey4,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (isLoading.value) ...[
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                  ]
                ],
              ),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    verifyOtp(email, otp.value, context);
                  },
                  child: const Text('Verify'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<bool> verifyOtp(String email, String otp, BuildContext context) async {
    try {
      var body = {"email": email, "otp": otp};
      log(body.toString());
      var response = await http.post(
        Uri.parse(ApiConstants.verifyOtpEndPoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        SharedPrefs.setUserEmail(email);
        var data = jsonDecode(response.body);
        SharedPrefs.setToken(data['token']);
        Get.snackbar("Suceess", "Email Verified");
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigator(
              initialIndex: 2,
            ),
          ),
        );
        updateVerifyOtpStatus(true);
        return true;
      } else {
        Get.snackbar("Failed", "Email Not Verified");
        Navigator.pop(context);
        log("Something went wrong");
      }
    } catch (e) {
      log("Error : $e");
      return false;
    }
    return false;
  }
}
