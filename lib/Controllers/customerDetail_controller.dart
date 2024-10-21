import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../screen/auth/sign_in/sign_in.dart';

class CustomerDetailController extends GetxController {
  var isLoading = false.obs;
  // Variables to hold form data
  var firstName = ''.obs;
  var lastName = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var selectedPickUpLocation = ''.obs;
  var selectedDropOffLocation = ''.obs;
  var otp = ''.obs;
  var verifyOtpStatus = false.obs;

  // Additional options state
  var isAdditionalOptionEnabled = false.obs;
  var isAdditionalDriver = false.obs;
  var isChildBoosterSeat = false.obs;
  var isChildSeat = false.obs;
  var isExitPermit = false.obs;

  // Method to update form data
  void updateFirstName(String value) {
    firstName.value = value;
  }

  void updateLastName(String value) {
    lastName.value = value;
  }

  void updatePhoneNumber(String value) {
    phoneNumber.value = value;
  }

  void updateEmail(String value, BuildContext context) {
    email.value = value;
    String? validEmail = validateEmail(value);
  }

  void updateOtp(String value){
    otp.value = value;
  }

  void toggleAdditionalOption(bool value) {
    isAdditionalOptionEnabled.value = value;
  }

  void toggleAdditionalDriver(bool value) {
    isAdditionalDriver.value = value;
  }

  void toggleChildBoosterSeat(bool value) {
    isChildBoosterSeat.value = value;
  }

  void toggleChildSeat(bool value) {
    isChildSeat.value = value;
  }

  void toggleExitPermit(bool value) {
    isExitPermit.value = value;
  }

  void updateLoading(bool value){
    isLoading.value = value;
  }

  void updateVerifyOtpStatus(bool value){
    verifyOtpStatus.value = value;
  }

  // function to validate the email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter an email";
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  void verifyEmail(String? email, BuildContext context) {
    if (email != null) {
      fetchOTP(email);
      _verifyEmailDailogBox(email, context);
    }
  }

  // void _verifyEmailDailogBox(String email, BuildContext context) {
  //   showCupertinoDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CupertinoAlertDialog(
  //         title: const Text('Verify Email'),
  //         content: Column(
  //           children: [
  //             const SizedBox(height: 10),
  //             Text('OTP has been sent to $email'),
  //             const SizedBox(height: 20),
  //             CupertinoTextField(
  //               onChanged: updateOtp,
  //               placeholder: 'Enter OTP',
  //               keyboardType: TextInputType.number,
  //               maxLength: 6,
  //               textAlign: TextAlign.center,
  //               decoration: BoxDecoration(
  //                 border: Border.all(
  //                   color: CupertinoColors.systemGrey4,
  //                 ),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           CupertinoDialogAction(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           CupertinoDialogAction(
  //             onPressed: () {
  //               verifyUserEmail();
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Verify'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
                  onPressed: ()  {
                    verifyOtp(email, otp.value).whenComplete((){
                      if(verifyOtpStatus.value){
                        Navigator.pop(context);
                      } else {
                        log("Something went wrong");
                      }
                    });
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

  // Method to handle form submission
  // void submitForm() {
  //   // Logic to handle form submission (e.g., API call, form validation)
  //   print('Full Name: ${firstName.value}');
  //   print('Full Name: ${lastName.value}');
  //   print('Phone Number: ${phoneNumber.value}');
  //   print('Email: ${email.value}');
  //   print('Pick Up Location: ${selectedPickUpLocation.value}');
  //   print('Drop Off Location: ${selectedDropOffLocation.value}');
  // }

  Future<void> fetchOTP(String email) async {
    const url = "https://locafri.ultimatetrueweb.com/api/login";
    try {
      var body = {"email": email};
      var response = await http.post(
        Uri.parse(url),
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

  Future<bool> verifyOtp(String email, String otp) async {
    const url = "http://locafri.ultimatetrueweb.com/api/verify-otp";
    try {
      var body =
      {
        "email": email,
        "otp": otp
      };
      log(body.toString());
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        updateVerifyOtpStatus(true);
        return true;
      }
    } catch (e) {
      log("Error : $e");
      return false;
    }
    return false;
  }

  Future<void> submitForm(BuildContext context) async {
    // Define API URL
    const url = 'http://locafri.ultimatetrueweb.com/api/create-contract';
    try {
      // Build the form data
      var formData = {
        'first_name': firstName.value,
        'last_name': lastName.value,
        'phone': phoneNumber.value,
        'email': email.value,
        'pickUpLocation': selectedPickUpLocation.value,
        'dropOffLocation': selectedDropOffLocation.value,
        'additional_driver': isAdditionalDriver.value ? '1' : '0',
        'booster_seat': isChildBoosterSeat.value ? '1' : '0',
        // Add remaining fields like dates, times, prices, etc.
      };
      // Make the HTTP POST request
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: formData,
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        print('Success: ${responseData}');

        Get.to(() => const Sign_in());
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Exception: $e');
    }
  }
}
