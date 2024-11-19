import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:carapp/utils/api_contants.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CheckOutContractController extends GetxController {
  RxBool isChecked = false.obs;
  var isLoading = false.obs;
  var statusCode = ''.obs;
  var needleValue = 10.0.obs;
  RxBool isGaugeActive = false.obs;

  void updateNeedleValue(double value) {
    needleValue.value = value.clamp(0, 9);
  }

  void toggleCheckbox(bool value) {
    isChecked.value = value;
  }

  Rx<File?> licenceImage = Rx<File?>(null);
  Future<void> pickImageFromCamera1() async {
    final licenseImagePicker =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (licenseImagePicker != null) {
      licenceImage.value = File(licenseImagePicker.path);
    }
  }

  Future<void> pickImageFromGallery1() async {
    final licenseImagePicker1 =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (licenseImagePicker1 != null) {
      licenceImage.value = File(licenseImagePicker1.path);
    }
  }

  void deleteImage() {
    licenceImage.value = null;
  }

  Rx<File?> odometerImage = Rx<File?>(null);
  Future<void> pickOdometerImageCamera() async {
    final pickedOdometerFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedOdometerFile != null) {
      odometerImage.value = File(pickedOdometerFile.path);
    }
  }

  Future<void> pickOdometerImageGallery() async {
    final pickedOdometerFile1 =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedOdometerFile1 != null) {
      odometerImage.value = File(pickedOdometerFile1.path);
    }
  }

  void deleteOdometerImage() {
    odometerImage.value = null;
  }

  final ImagePicker _picker = ImagePicker();
  var vehicleImages = RxList<File?>(List.filled(4, null));

  Future<void> pickImageFromCamera(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      vehicleImages[index] = File(pickedFile.path);
    }
  }

  Future<void> pickImageFromGallery(int index) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      vehicleImages[index] = File(pickedFile.path);
    }
  }

  void deleteVehicleImage(int index) {
    vehicleImages[index] = null;
  }

  Future<void> uploadCheckOutContract(
      {required String name,
      required String address,
      required String postalCode,
      required String email,
      required String recordKilometers,
      required Rx<File?> signatureImage,
      required String fuelLevel,
      required String comment,
      required String contractId,
      required BuildContext context}) async {
    isLoading.value = true;
    showDialogBox();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.checkoutEndPoint),
    );

    request.headers.addAll({
      "Content-Type": "application/form-data",
      'Authorization': 'Bearer ${SharedPrefs.getToken}',
    });

    request.fields['name'] = name;
    request.fields['address'] = address;
    request.fields['postal_code'] = postalCode;
    request.fields['email'] = email;
    request.fields['record_kilometers'] = recordKilometers;
    request.fields['fuel_level'] = (needleValue.value * 10.0).toString();
    request.fields['vehicle_damage_comments'] = comment;
    request.fields['contract_id'] = contractId;

    if (signatureImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'customer_signature',
        signatureImage.value!.path,
      ));
    }

    if (licenceImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'license_photo',
        licenceImage.value!.path,
      ));
    }

    if (odometerImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'fuel_image',
        odometerImage.value!.path,
      ));
    }

    for (int i = 0; i < vehicleImages.length; i++) {
      if (vehicleImages[i] != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'vehicle_images[]',
          vehicleImages[i]!.path,
        ));
      }
    }

    try {
      var response = await request.send();
      statusCode.value = response.statusCode.toString();
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        print('Check-out completed: ${jsonResponse['message']}');
      }
    } catch (e) {
      print('Error uploading contract: $e');
    } finally {
      isLoading.value = false;
      Get.back();
      if (statusCode.value == "200") {
        Get.snackbar("Success", "Check Out form submitted.");
      } else {
        Get.snackbar("Failed", "Something went wrong.");
      }
    }
  }

  void showDialogBox() {
    if (isLoading.value) {
      Get.dialog(
        Center(
          child: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }
}
