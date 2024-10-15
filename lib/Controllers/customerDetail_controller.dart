import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../screen/auth/sign_in/sign_in.dart';

class CustomerDetailController extends GetxController {
  // Variables to hold form data
  var firstName = ''.obs;
  var lastName = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var selectedPickUpLocation = ''.obs;
  var selectedDropOffLocation = ''.obs;

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

  void updateEmail(String value) {
    email.value = value;
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
