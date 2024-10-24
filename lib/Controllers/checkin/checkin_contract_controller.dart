import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:carapp/utils/api_contants.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

  class CheckinContractController extends GetxController {
  RxBool isChecked = false.obs;
  var isLoading = false.obs;
  var statusCode = ''.obs;

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

  Future<void> uploadCheckinContract(String name, String address, String postalCode, String email, String recordKilometers, String fuelLevel,
      String vehicleDamageComments, Rx<File?> signatureImage, BuildContext context) async {
    isLoading.value = true;
    showDialogBox();

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstants.checkinEndPoint),
    );

    request.headers.addAll({
      "Content-Type": "application/form-data",
    });

    request.fields['name'] = name;
    request.fields['address'] = address;
    request.fields['postal_code'] = postalCode;
    request.fields['email'] = email;
    request.fields['record_kilometers'] = recordKilometers;
    request.fields['fuel_level'] = fuelLevel;
    request.fields['vehicle_damage_comments'] = vehicleDamageComments;

    if(signatureImage.value != null){
      request.files.add(await http.MultipartFile.fromPath(
        'customer_signature', signatureImage.value!.path,
      ));
    }

    if (licenceImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'license_photo', licenceImage.value!.path,
      ));
    }

    if (odometerImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'odometer_image', odometerImage.value!.path,
      ));
    }

    for (int i = 0; i < vehicleImages.length; i++) {
      if (vehicleImages[i] != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'vehicle_images[]', vehicleImages[i]!.path,
        ));
      }
    }

    try {
      var response = await request.send();
      log(response.statusCode.toString());
      statusCode.value = response.statusCode.toString();
      if (response.statusCode == 201) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        log("The response is : ${jsonResponse}");
        print("Contract id: ${jsonResponse['id']}");
        print('Check-in completed: ${jsonResponse['message']}');
        await SharedPrefs.setContractId(jsonResponse["data"]["id"]);
      }
    } catch (e) {
      print('Error uploading contract: $e');
    } finally {
      isLoading.value = false;
      Get.back();
      if(statusCode.value == "201") {
        Get.snackbar("Success", "Check in form submitted.");
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
