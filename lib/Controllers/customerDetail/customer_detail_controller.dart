import 'dart:convert';
import 'dart:developer';
import 'package:carapp/models/create_contract_data.dart';
import 'package:carapp/models/payment_data_model.dart';
import 'package:carapp/utils/api_contants.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:carapp/widget/bottomnavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CustomerDetailController extends GetxController {
  var isLoading = false.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var phoneNumber = ''.obs;
  var city = ''.obs;
  var zipCode = ''.obs;
  var address = ''.obs;
  var email = ''.obs;
  var selectedPickUpLocation = ''.obs;
  var selectedDropOffLocation = ''.obs;
  var otp = ''.obs;
  var verifyOtpStatus = false.obs;
  var dropOfDate = ''.obs;
  var dropOfTime = ''.obs;
  var month = '0'.obs;
  var week = '0'.obs;
  var days = '0'.obs;
  var totalPrice = Rx<TextEditingController>(TextEditingController());
  var paymentRedirectUrl = ''.obs;
  CreateContractData? createContractData;
  PaymentData? paymentData;
  RxString endPrice = "0".obs;
  RxList paymentType = <String>["PAY PARTIALLY 10%", "PAY FULL AMOUNT"].obs;
  var stripePaymentType = "PAY PARTIALLY 10%".obs;
  RxBool loading = false.obs;

  var isAdditionalOptionEnabled = false.obs;
  var isAdditionalDriver = false.obs;
  var isChildBoosterSeat = false.obs;
  var isChildSeat = false.obs;
  var isExitPermit = false.obs;
  var pickUpDate = DateTime.now().obs;
  var pickUpTime = TimeOfDay.now().obs;
  var dropOffDate = DateTime.now().obs;
  var dropOffTime = TimeOfDay.now().obs;
  var driverFirstName = ''.obs;
  var driverLastName = ''.obs;
  var totalPrices = 0.0.obs;
  void updateDriverFirstName(String value) {
    driverFirstName.value = value;
  }

  void updateDriverLastName(String value) {
    driverLastName.value = value;
  }

  void updateFirstName(String value) {
    firstName.value = value;
  }

  void updateLastName(String value) {
    lastName.value = value;
  }

  void updatePhoneNumber(String value) {
    phoneNumber.value = value;
  }

  void updateAddress(String value) {
    address.value = value;
  }

  void updateCity(String value) {
    city.value = value;
  }

  void updateZipCode(String value) {
    zipCode.value = value;
  }

  void updateEmail(String value, BuildContext context) {
    email.value = value;
  }

  void updateOtp(String value) {
    otp.value = value;
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
    double price = calculateAdditional();
    updateTotalAdditional(value, price);
  }

  void toggleChildBoosterSeat(bool value) {
    isChildBoosterSeat.value = value;
    double price = calculateChildBoosterSeatPrice();
    updateTotalPrices(value, price);
  }

  void toggleChildSeat(bool value) {
    isChildSeat.value = value;
    double price = calculateChildSeatPrice();
    updateTotalPrices(value, price);
  }

  void toggleExitPermit(bool value) {
    isExitPermit.value = value;
    double price = calculateExitPermitPrice();
    updateTotalPriceExit(value, price);
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
    if (email != null && email.isNotEmpty) {
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
              title: const Text('Vérifier l\'e-mail'),
              content: Column(
                children: [
                  const SizedBox(height: 10),
                  Text('OTP a été envoyé à $email'),
                  const SizedBox(height: 20),
                  CupertinoTextField(
                    onChanged: updateOtp,
                    placeholder: 'Entrez OTP',
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
                  child: const Text('Annuler'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    verifyOtp(email, otp.value).whenComplete(
                      () {
                        if (verifyOtpStatus.value) {
                          Navigator.pop(context);
                          Get.snackbar("Succès", "E-mail vérifié");
                        } else {
                          Navigator.pop(context);
                          Get.snackbar(
                              "Échoué", "Quelque chose s'est mal passé");
                          log("Something went wrong");
                        }
                      },
                    );
                  },
                  child: const Text('Vérifier'),
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
        var data = jsonDecode(response.body);
        SharedPrefs.setUserEmail(email);
        SharedPrefs.setToken(data['token']);
        updateVerifyOtpStatus(true);
        return true;
      }
    } catch (e) {
      log("Error : $e");
      return false;
    }
    return false;
  }

  double calculateChildBoosterSeatPrice() {
    final int daysCount = int.tryParse(days.value) ?? 0;
    final int weeksCount = int.tryParse(week.value) ?? 0;
    final int monthsCount = int.tryParse(month.value) ?? 0;
    // return (daysCount * 5) + (weeksCount * 30) + (monthsCount * 50);
    return 20.0;
  }

  double calculateChildSeatPrice() {
    final int daysCount = int.tryParse(days.value) ?? 0;
    final int weeksCount = int.tryParse(week.value) ?? 0;
    final int monthsCount = int.tryParse(month.value) ?? 0;
    // return (daysCount * 5) + (weeksCount * 30) + (monthsCount * 50);
    return 30.0;
  }

  double calculateAdditional() {
    final int daysCount = int.tryParse(days.value) ?? 0;
    final int weeksCount = int.tryParse(week.value) ?? 0;
    final int monthsCount = int.tryParse(month.value) ?? 0;
    // return (daysCount * 20) + (weeksCount * 30) + (monthsCount * 50);
    return 20;
  }

  void updateTotalAdditional(bool isAddition, double price) {
    double total = calculateAdditional();
    if (isAddition == true) {
      endPrice.value =
          (double.parse(endPrice.value) + total).toStringAsFixed(2);
    } else {
      endPrice.value =
          (double.parse(endPrice.value) - total).toStringAsFixed(2);
    }
  }

  double calculateDailyPrice149() {
    final int daysCount = int.tryParse(days.value) ?? 0;
    return 149; // ₹149 per day
  }

  double calculateExitPermitPrice() {
    return calculateDailyPrice149(); // ₹149 per day for the exit permit
  }

  void updateTotalPriceExit(bool isAddition, double priceChange) {
    double currentTotal = double.tryParse(endPrice.value) ?? 0.0;

    if (isAddition) {
      currentTotal += priceChange;
    } else {
      currentTotal -= priceChange;
    }

    endPrice.value = currentTotal.toStringAsFixed(2);
  }

  // double calculateAdditionalOptionPrice() {
  //   double price = 0.0;
  //
  //   if (isAdditionalDriver.value) {
  //     price += 20.0;
  //   }
  //
  //   if (isChildBoosterSeat.value) {
  //     price += calculateChildBoosterSeatPrice();
  //   }
  //
  //   if (isChildSeat.value) {
  //     price += calculateChildSeatPrice();
  //   }
  //
  //   if (isExitPermit.value) {
  //     price += 149.0;
  //   }
  //
  //   return price;
  // }

  // void updateTotalPrice() {
  //   double total = calculateAdditionalOptionPrice();
  //   endPrice.value = (double.parse(endPrice.value) + total).toStringAsFixed(2);
  // }

  calculateTotalPrice(
    String dprice,
    String wprice,
    String mprice,
  ) {
    double price =
        (double.parse(days.toString()) * double.parse(dprice.toString())) +
            (double.parse(week.toString()) * double.parse(wprice.toString())) +
            (double.parse(month.toString()) * double.parse(month.toString()));
    totalPrice.value.text = price.toString();
    endPrice.value = price.toStringAsFixed(2);
  }

  // Method to update the total price based on toggle
  void updateTotalPrices(bool isAddition, double price) {
    double total = calculateChildBoosterSeatPrice();
    if (isAddition == true) {
      endPrice.value =
          (double.parse(endPrice.value) + total).toStringAsFixed(2);
    } else {
      endPrice.value =
          (double.parse(endPrice.value) - total).toStringAsFixed(2);
    }
  }

  // Toggle function for Child Booster Seat
  void toggleChildBoosterSeats(bool value) {
    isChildBoosterSeat.value = value;
    double price = calculateChildBoosterSeatPrice();
    updateTotalPrices(value, price); // Update total based on toggle state
  }

  Map<String, int> calculateDateDifference(
    DateTime pickupDate,
    DateTime dropOffDate,
    String dprice,
    String wprice,
    String mprice,
  ) {
    if (pickupDate.isAfter(dropOffDate)) {
      throw ArgumentError("Pickup date must be before drop-off date.");
    }

    int months = 0;
    int weeks = 0;
    int days = 0;

    while (pickupDate.year < dropOffDate.year ||
        (pickupDate.year == dropOffDate.year &&
            pickupDate.month < dropOffDate.month)) {
      months++;
      pickupDate = DateTime(pickupDate.year, pickupDate.month + 1, 1);
    }

    days = dropOffDate.day - pickupDate.day;
    weeks = days ~/ 7;
    days = days % 7;

    log("The days are : $days, weeks are $weeks and the months are $months");

    updateMonth(months.toString());
    updateWeek(weeks.toString());
    updateDays(days.toString());
    calculateTotalPrice(dprice, wprice, mprice);

    return {
      'months': months,
      'weeks': weeks,
      'days': days,
    };
  }

  String getTimeValue(TimeOfDay timeOfDay) {
    final String hour = timeOfDay.hour.toString().padLeft(2, '0');
    final String minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String getDateValue(DateTime dateTime) {
    final String year = dateTime.year.toString();
    final String month = dateTime.month.toString().padLeft(2, '0');
    final String day = dateTime.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  Future<bool> submitForm(
    BuildContext context,
    String vehicleName,
    String dprice,
    String wprice,
    String mprice,
  ) async {
    loading.value = true;
    try {
      var formData = {
        'first_name': firstName.value,
        'last_name': lastName.value,
        'phone': phoneNumber.value,
        'email': email.value,
        'address_first': address.value,
        'address_last': '',
        'zipcode': zipCode.value,
        'city': city.value,
        'vehicle_name': vehicleName,
        'Dprice': dprice,
        'wprice': wprice,
        'mprice': mprice,
        'pickUpLocation': selectedPickUpLocation.value,
        'dropOffLocation': selectedDropOffLocation.value,
        'pickUpDate': getDateValue(pickUpDate.value),
        'pickUpTime': getTimeValue(pickUpTime.value),
        'collectionDate': getDateValue(dropOffDate.value),
        'collectionTime': getTimeValue(dropOffTime.value),
        'month_count': month.value,
        'week_count': week.value,
        'day_count': days.value,
        'additional_driver': isAdditionalDriver.value ? '1' : '0',
        'booster_seat': isChildBoosterSeat.value ? '1' : '0',
        'child_seat': isChildSeat.value ? '1' : '0',
        'exit_permit': isExitPermit.value ? '1' : '0',
        'payment_type': '1'
      };

      log(formData.toString());

      var response = await http.post(
        Uri.parse(ApiConstants.createContractEndPoint),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer ${SharedPrefs.getToken}',
        },
        body: formData,
      );

      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        createContractData = CreateContractData.fromJson(responseData);
        log(responseData.toString());
        loading.value = false;
        await stripePaymentCall(createContractData!, context);
        print('Success: ${responseData}');
        SharedPrefs.setUserFirstName(firstName.value);
        SharedPrefs.setUserLastName(lastName.value);
        SharedPrefs.setUserPhoneNumber(phoneNumber.value);
        // SharedPrefs.setUserEmail(email.value);
        return true;
      } else {
        print('Error: ${response.statusCode}');
        Get.snackbar("Échoué", "Quelque chose s'est mal passé..");
        loading.value = false;
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar("Échoué", "Quelque chose s'est mal passé..");
      loading.value = false;
      return false;
    }
  }

  // Stripe Payment API Call
  Future<bool> stripePaymentCall(
      CreateContractData createContractData, BuildContext context) async {
    try {
      // Construct request body
      var paymentBody = {
        "price": "${createContractData.price}",
        "vehicle_name": createContractData.vehicleName ?? "",
        "customer_email": createContractData.customerEmail ?? "",
        "booking_id": createContractData.bookingId.toString(),
        "payment_type": stripePaymentType.value == paymentType[0]
            ? "payment_partial"
            : "payment_full",
      };

      // Make API call
      var response = await http.post(
        Uri.parse(ApiConstants.stripePaymentEndPoint),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer ${SharedPrefs.getToken}',
        },
        body: paymentBody,
      );
      print("Bearer ${SharedPrefs.getToken}");
      log("Response Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        // Save the redirect URL for navigation
        paymentRedirectUrl.value = responseData["redirectUrl"];
        log("Redirect URL: ${responseData["redirectUrl"]}");

        // Return true on successful payment initiation
        return true;
      } else {
        log("Payment API Error: ${response.body}");
        return false;
      }
    } catch (e) {
      log("Payment Call Exception: $e");
      return false;
    }
  }

  Future<void> fetchStripePaymentDetails(String url) async {
    showSuceessDialogBox(
        Icons.check, Colors.green, "Payment Done \n Sucessfully..");
    // try {
    //   var response = await http.get(Uri.parse(url));

    //   if (response.statusCode == 200) {
    //     var responseData = jsonDecode(response.body);
    //     paymentData = PaymentData.fromJson(responseData);
    //     if (paymentData!.data!.status == "complete") {
    //       showSuceessDialogBox(
    //           Icons.check, Colors.green, "Payment Done \n Sucessfully..");
    //     } else {
    //       showSuceessDialogBox(Icons.close, Colors.red, "Payment Pending..");
    //     }
    //   } else {
    //     showSuceessDialogBox(Icons.close, Colors.red, "Something went wrong");
    //   }
    // } catch (e) {
    //   print("e");
    //   showSuceessDialogBox(Icons.close, Colors.red, "Something went wrong");
    // }
  }

  void showSuceessDialogBox(IconData icon, Color iconColor, String message) {
    Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            height: 150.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Thank you, Your Response has been submitted",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
