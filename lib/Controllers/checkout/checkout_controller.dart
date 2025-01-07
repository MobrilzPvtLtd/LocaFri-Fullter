import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:carapp/utils/api_contants.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:carapp/widget/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

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

  // Future<void> uploadCheckOutContract({
  //   required String name,
  //   required String address,
  //   required String postalCode,
  //   required String email,
  //   required String recordKilometers,
  //   required Rx<File?> signatureImage,
  //   required String fuelLevel,
  //   required String comment,
  //   required String contractId,
  //   required BuildContext context,
  // }) async {
  //   isLoading.value = true;  // Start the loader
  //   showDialogBox();  // Show the loading dialog
  //
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(ApiConstants.checkoutEndPoint),
  //   );
  //
  //   // Add request headers
  //   request.headers.addAll({
  //     "Content-Type": "application/form-data",
  //     'Authorization': 'Bearer ${SharedPrefs.getToken}',
  //   });
  //
  //   // Add form fields
  //   request.fields['contract_id'] = contractId;
  //   request.fields['name'] = name;
  //   request.fields['address'] = address;
  //   request.fields['postal_code'] = postalCode;
  //   request.fields['email'] = email;
  //   request.fields['record_kilometers'] = recordKilometers;
  //   request.fields['fuel_level'] = (fuelLevel);  // Ensure correct data
  //   request.fields['vehicle_damage_comments'] = comment;
  //
  //   // Add images if available
  //   if (signatureImage.value != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'customer_signature',
  //       signatureImage.value!.path,
  //     ));
  //   }
  //
  //   // Add other images conditionally (example for other files)
  //   if (licenceImage.value != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'license_photo',
  //       licenceImage.value!.path,
  //     ));
  //   }
  //
  //   if (odometerImage.value != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'fuel_image',
  //       odometerImage.value!.path,
  //     ));
  //   }
  //
  //   // Handle multiple vehicle images
  //   for (int i = 0; i < vehicleImages.length; i++) {
  //     if (vehicleImages[i] != null) {
  //       request.files.add(await http.MultipartFile.fromPath(
  //         'vehicle_images[]',
  //         vehicleImages[i]!.path,
  //       ));
  //     }
  //   }
  //
  //   try {
  //     var response = await request.send();
  //     var responseBody = await response.stream.bytesToString();
  //     statusCode.value = response.statusCode.toString();
  //
  //     if (response.statusCode == 200) {
  //       var jsonResponse = json.decode(responseBody);
  //       print('Check-out completed: ${jsonResponse['message']}');
  //       Get.snackbar("Success", "Check-out form submitted successfully.");
  //     } else {
  //       var jsonResponse = json.decode(responseBody);
  //       String errorMessage = jsonResponse['message'] ?? 'Something went wrong!';
  //       print('Error response: $errorMessage');
  //       Get.snackbar("Failed", errorMessage);
  //     }
  //   } catch (e) {
  //     print('Error uploading contract: $e');
  //     Get.snackbar("Failed", "An error occurred: $e");
  //   } finally {
  //     isLoading.value = false;  // Stop the loader
  //     if (Get.isDialogOpen ?? false) {  // Close the loader dialog if open
  //       Get.back();
  //     }
  //   }
  // }

  Future<void> uploadCheckOutContract({
    required String name,
    required String address,
    required String postalCode,
    required String email,
    required String recordKilometers,
    required Rx<File?> signatureImage,
    required String fuelLevel,
    required String comment,
    required String contractId,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.checkoutEndPoint),
    );

    request.headers.addAll({
      "Content-Type": "application/form-data",
      'Authorization': 'Bearer ${SharedPrefs.getToken}',
    });

    // Add form fields
    request.fields['contract_id'] = contractId;
    request.fields['name'] = name;
    request.fields['address'] = address;
    request.fields['postal_code'] = postalCode;
    request.fields['email'] = email;
    request.fields['record_kilometers'] = recordKilometers;
    request.fields['fuel_level'] = fuelLevel;
    request.fields['vehicle_damage_comments'] = comment;

    // Compress and add signature image if available
    if (signatureImage.value != null) {
      File compressedSignature = await compressImage(signatureImage.value!);
      request.files.add(await http.MultipartFile.fromPath(
        'customer_signature',
        compressedSignature.path,
      ));
    }

    // Compress and add other images if available
    if (licenceImage.value != null) {
      File compressedLicense = await compressImage(licenceImage.value!);
      request.files.add(await http.MultipartFile.fromPath(
        'license_photo',
        compressedLicense.path,
      ));
    }

    if (odometerImage.value != null) {
      File compressedOdometer = await compressImage(odometerImage.value!);
      request.files.add(await http.MultipartFile.fromPath(
        'fuel_image',
        compressedOdometer.path,
      ));
    }

    // Compress and add vehicle images
    for (int i = 0; i < vehicleImages.length; i++) {
      if (vehicleImages[i] != null) {
        File compressedVehicleImage = await compressImage(vehicleImages[i]!);
        request.files.add(await http.MultipartFile.fromPath(
          'vehicle_images[]',
          compressedVehicleImage.path,
        ));
      }
    }

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      statusCode.value = response.statusCode.toString();

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(responseBody);
        print('Check-out completed: ${jsonResponse['message']}');
        Get.snackbar("Success", "Check-out form submitted successfully.");
        Get.offAll(const BottomNavigator());
      } else {
        var jsonResponse = json.decode(responseBody);
        log(jsonResponse.toString());
        String errorMessage = jsonResponse['error'] ?? 'Something went wrong!';
        print('Error response: $errorMessage');
        Get.snackbar("Failed", errorMessage);
      }
      isLoading.value = false;
    } catch (e) {
      print('Error uploading contract: $e');
      Get.snackbar("Failed", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

// Function to compress an image file
  Future<File> compressImage(File file) async {
    final bytes = await file.readAsBytes();
    img.Image? image = img.decodeImage(bytes);

    // Resize the image to a smaller size (e.g., width: 800px)
    img.Image resizedImage = img.copyResize(image!, width: 800);

    // Compress the image and save it to a new file
    final compressedBytes =
        img.encodeJpg(resizedImage, quality: 70); // Adjust quality (0-100)

    final compressedFile = File(file.path)..writeAsBytesSync(compressedBytes);

    return compressedFile;
  }

  // void showDialogBox() {
  //   if (isLoading.value || !(Get.isDialogOpen ?? false)) { // Prevent multiple dialogs
  //     Get.dialog(
  //       Center(
  //         child: Container(
  //           width: 100.0,
  //           height: 100.0,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(8.0),
  //           ),
  //           child: const Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         ),
  //       ),
  //       barrierDismissible: false,
  //     );
  //   }
  // }
}
