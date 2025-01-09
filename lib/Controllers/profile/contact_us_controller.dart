import 'dart:convert';
import 'dart:developer';
import 'package:carapp/utils/api_contants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContactUsController extends GetxController {
  RxBool isLoading = false.obs;
  String? error;
  var isChecked = false.obs;

  bool validateCheckbox() {
    if (!isChecked.value) {
      Get.snackbar(
        "Erreur de validation",
        "Vous devez avoir lu les conditions et les accepter.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

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
        Get.snackbar("Succès", "Demande soumise avec succès");
        Get.showSnackbar(
          const GetSnackBar(
            title: "Merci de nous avoir contactés.",
            message:
                "Nous vous avons envoyé un email avec les informations que vous avez demandées.",
            duration: Duration(seconds: 3),
          ),
        );
        log(response.body.toString());
      } else {
        Get.snackbar("Échoué", "Quelque chose s'est mal passé");
      }
    } catch (e) {
      error = 'Error : $e';
      log(error.toString());
    }
    isLoading.value = false;
    update();
  }
}
