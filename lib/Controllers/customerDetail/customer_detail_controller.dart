import 'dart:convert';
import 'dart:developer';
import 'package:carapp/models/create_contract_data.dart';
import 'package:carapp/utils/api_contants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CustomerDetailController extends GetxController {
  var isLoading = false.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var selectedPickUpLocation = ''.obs;
  var selectedDropOffLocation = ''.obs;
  var otp = ''.obs;
  var verifyOtpStatus = false.obs;
  var pickUpDate = ''.obs;
  var pickUpTime = ''.obs;
  var dropOfDate = ''.obs;
  var dropOfTime = ''.obs;
  var month = '0'.obs;
  var week = '0'.obs;
  var days = '0'.obs;
  var paymentRedirectUrl = ''.obs;
  CreateContractData? createContractData;

  var isAdditionalOptionEnabled = false.obs;
  var isAdditionalDriver = false.obs;
  var isChildBoosterSeat = false.obs;
  var isChildSeat = false.obs;
  var isExitPermit = false.obs;

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
  }

  void updateOtp(String value) {
    otp.value = value;
  }

  void updatePickUpDate(String value) {
    pickUpDate.value = value;
  }

  void updatePickUpTime(String value) {
    pickUpTime.value = value;
  }

  void updateDropOfDate(String value) {
    dropOfDate.value = value;
  }

  void updateDropOfTime(String value) {
    dropOfTime.value = value;
  }

  void updateMonth(String value) {
    month.value = value;
  }

  void updateWeek(String value) {
    week.value = value;
  }

  void updateDays(String value) {
    days.value = value;
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

  void updateLoading(bool value) {
    isLoading.value = value;
  }

  void updateVerifyOtpStatus(bool value) {
    verifyOtpStatus.value = value;
  }

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
                    verifyOtp(email, otp.value).whenComplete(
                      () {
                        if (verifyOtpStatus.value) {
                          Navigator.pop(context);
                        } else {
                          log("Something went wrong");
                        }
                      },
                    );
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

  Future<bool> verifyOtp(String email, String otp) async {
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
        updateVerifyOtpStatus(true);
        return true;
      }
    } catch (e) {
      log("Error : $e");
      return false;
    }
    return false;
  }

  Map<String, int> calculateDateDifference(
      DateTime pickupDate, DateTime dropOffDate) {
    if (pickupDate.isAfter(dropOffDate)) {
      throw ArgumentError("Pickup date must be before drop-off date.");
    }

    int totalDays = dropOffDate.difference(pickupDate).inDays;

    int months = 0;
    int weeks = 0;

    DateTime currentDate = pickupDate;

    while (currentDate.year < dropOffDate.year ||
        (currentDate.year == dropOffDate.year &&
            currentDate.month < dropOffDate.month)) {
      months++;
      currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
    }

    currentDate = pickupDate;
    weeks = totalDays ~/ 7;

    updateMonth(months.toString());
    updateWeek(weeks.toString());
    updateDays(days.toString());

    return {
      'months': months,
      'weeks': weeks,
      'days': totalDays,
    };
  }

  Future<void> submitForm(
    BuildContext context,
    String vehicleName,
    String dprice,
    String wprice,
    String mprice,
  ) async {
    try {
      var formData = {
        'first_name': firstName.value,
        'last_name': lastName.value,
        'phone': phoneNumber.value,
        'email': email.value,
        'address_first': '', // optional
        'address_last': '', // optional
        'vehicle_name': vehicleName,
        'Dprice': dprice,
        'wprice': wprice,
        'mprice': mprice,
        'pickUpLocation': selectedPickUpLocation.value,
        'dropOffLocation': selectedDropOffLocation.value,
        'pickUpDate': pickUpDate.value,
        'pickUpTime': pickUpTime.value,
        'collectionDate': dropOfDate.value,
        'collectionTime': dropOfTime.value,
        'month_count': month.value,
        'week_count': week.value,
        'day_count': days.value,
        'additional_driver': isAdditionalDriver.value ? '1' : '0', // optional
        'booster_seat': isChildBoosterSeat.value ? '1' : '0', // optional
        'child_seat': isChildSeat.value ? '1' : '0', // optional
        'exit_permit': isExitPermit.value ? '1' : '0', // optional
        'payment_type': '1'
      };

      log(formData.toString());

      var response = await http.post(
        Uri.parse(ApiConstants.createContractEndPoint),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: formData,
      );

      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        createContractData = CreateContractData.fromJson(responseData); 
        log(responseData.toString());  
        stripePaymentCall(createContractData!);
        print('Success: ${responseData}');
        Get.snackbar("Success", "Detail Form Submitted..");
      } else {
        print('Error: ${response.statusCode}');
        Get.snackbar("Failed", "Something went wrong..");
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar("Failed", "Something went wrong..");
    }
  }

  // Stripe Payment API Call
  Future<void> stripePaymentCall(CreateContractData createContractData) async {

    try {
      var paymentBody = {
        "price": createContractData.price.toString(),
        "vehicle_name": createContractData.vehicleName ?? "",
        "customer_email": createContractData.vehicleName ?? "",
        "booking_id": createContractData.bookingId.toString(),
        "payment_type": createContractData.paymentType ?? ""
      }; 

      var response = await http.post(
        Uri.parse(ApiConstants.stripePaymentEndPoint),
        body: paymentBody,
      );

      log(response.statusCode.toString());

      if(response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        paymentRedirectUrl.value = responseData["redirectUrl"]; 
        log(responseData["redirectUrl"]);
      }

    } catch (e) {
      print(e);
    }
  }
}
