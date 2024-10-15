// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// class CheckinContractController extends GetxController {
//
//   RxBool isChecked = false.obs;
//     void toggleCheckbox(bool value) {
//     isChecked.value = value;
//      }
//
//      //////////// ********* Upload-License-Image **********  /////////////////
//
//     Rx<File?> licenceImage = Rx<File?>(null);
//     // Pick image from camera
//     Future<void> pickImageFromCamera1() async {
//     final licenseImagePicker =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     if (licenseImagePicker != null) {
//       licenceImage.value = File(licenseImagePicker.path);
//     }
//   }
//
//   // Pick image from gallery
//   Future<void> pickImageFromGallery1() async {
//     final licenseImagePicker1 =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (licenseImagePicker1 != null) {
//       licenceImage.value = File(licenseImagePicker1.path);
//     }
//   }
//
//   // Delete image
//   void deleteImage() {
//     licenceImage.value = null;
//   }
//
//   /////////////// ******** Fuel-Images-upload  *********** ////////////////
//
//   Rx<File?> odometerImage = Rx<File?>(null);
//   // Pick image from camera
//
//   Future<void> pickOdometerImageCamera() async {
//     final pickedOdometerFile =
//         await _picker.pickImage(source: ImageSource.camera);
//     if (pickedOdometerFile != null) {
//       odometerImage.value = File(pickedOdometerFile.path);
//     }
//   }
//
//   // Pick image from gallery
//   Future<void> pickOdometerImageGallery() async {
//     final pickedOdometerFile1 =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedOdometerFile1 != null) {
//       odometerImage.value = File(pickedOdometerFile1.path);
//     }
//   }

//   // Delete image
//   void deleteOdometerImage() {
//     odometerImage.value = null;
//   }
//   //////////////// ********* Upload-vehicleImages-Image **********  /////////////////
//
//   final ImagePicker _picker = ImagePicker();
//   var vehicleImages = RxList<File?>(List.filled(4, null));
//
//   // Pick image from camera
//   Future<void> pickImageFromCamera(int index) async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       vehicleImages[index] = File(pickedFile.path);
//     }
//   }
//
//   // Pick image from gallery
//   Future<void> pickImageFromGallery(int index) async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       vehicleImages[index] = File(pickedFile.path);
//     }
//   }
//
//   // Delete image
//   void deleteVehicleImage(int index) {
//     vehicleImages[index] = null;
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// }

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../widget/bottomnavigation.dart';

  class CheckinContractController extends GetxController {
  var isLoading = false.obs;
  RxBool isChecked = false.obs;

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

  // API call to upload check-in contract
  Future<void> uploadCheckinContract(String recordKilometers, String fuelLevel,
      String vehicleDamageComments, String customerSignature) async {

    var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://your-api-endpoint.com/api/checkin')
    );

    // Add text fields
    request.fields['record_kilometers'] = recordKilometers;
    request.fields['fuel_level'] = fuelLevel;
    request.fields['vehicle_damage_comments'] = vehicleDamageComments;
    request.fields['customer_signature'] = customerSignature;

    // Add license image

    if (licenceImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'license_photo', licenceImage.value!.path,
        filename: basename(licenceImage.value!.path),
      ));
    }

    // Add odometer image
    if (odometerImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'odometer_image', odometerImage.value!.path,
        filename: basename(odometerImage.value!.path),
      ));
    }

    // Add vehicle images
    for (int i = 0; i < vehicleImages.length; i++) {
      if (vehicleImages[i] != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'vehicle_images[]', vehicleImages[i]!.path,
          filename: basename(vehicleImages[i]!.path),
        ));
      }
    }

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);

        print('Check-in completed: ${jsonResponse['message']}');
        isLoading(false);
        Get.offAll(() => BottomNavigator());
      } else {
        // Get.to(Sign_in());
        // print('Failed to upload contract. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading contract: $e'); 
    }
  }
}
