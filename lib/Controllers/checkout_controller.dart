import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CheckOutContractController extends GetxController {
  RxBool isChecked = false.obs;
  var isLoading = false.obs;
  var statusCode = ''.obs;

  void toggleCheckbox(bool value) {
    isChecked.value = value;
  }

  // License Image
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

  // Odometer Image
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

  // Vehicle Images
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

  // API call to upload check-out contract
  Future<void> uploadCheckOutContract(
  {
    required String name,
    required String address,
    required String postalCode,
    required String email,
    required String recordKilometers,
    required Rx<File?> signatureImage,
    required String fuelLevel,
    required String comment,
    required String contractId,
    required BuildContext context
}) async {
    isLoading.value = true;
    showDialogBox();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://locafri.ultimatetrueweb.com/api/checkout'),
    );

    request.headers.addAll({
      "Content-Type": "application/form-data",
    });

    // Add text fields
    request.fields['name'] = name;
    request.fields['address'] = address;
    request.fields['postal_code'] = postalCode;
    request.fields['email'] = email;
    request.fields['record_kilometers'] = recordKilometers;

    // Add Customer Signature Image
    if (signatureImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'customer_signature', signatureImage.value!.path,
      ));
    }

    // Add license image
    if (licenceImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'license_photo', licenceImage.value!.path,
      ));
    }

    // Add odometer image
    if (odometerImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'odometer_image', odometerImage.value!.path,
      ));
    }

    // Add vehicle images
    for (int i = 0; i < vehicleImages.length; i++) {
      if (vehicleImages[i] != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'vehicle_images[]', vehicleImages[i]!.path,
        ));
      }
    }

    try {
      var response = await request.send();
      statusCode.value = response.statusCode.toString();
      if (response.statusCode == 201) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        print('Check-in completed: ${jsonResponse['message']}');
      }
    } catch (e) {
      print('Error uploading contract: $e');
    } finally {
      isLoading.value = false;
      Get.back();
      if (statusCode.value == "201") {
        Get.snackbar("Success", "Check in form submitted.");
      } else {
        Get.snackbar("Failure", "Something went wrong pls try again..");
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
