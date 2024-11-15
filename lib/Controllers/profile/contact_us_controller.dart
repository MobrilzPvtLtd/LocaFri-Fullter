import 'dart:convert';
import 'dart:developer';
import 'package:carapp/utils/api_contants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContactUsController extends GetxController {
  RxBool isLoading = false.obs;
  String? error;

  Future<void> sendRequest(String name, String email, String message) async {
    isLoading.value = true;
    error = null;
    update();
    try {
      var body = {"name": name, "email": email, "message": message};
      var response = await http.post(
        Uri.parse(ApiConstants.contactUsEndPoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Request Successfully Submitted");
        Get.showSnackbar(
          const GetSnackBar(
            title: "Thank you for contacting us.",
            message:
                "We have sent you an email with the information you have requested.",
            duration: Duration(seconds: 3),
          ),
        );
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
