import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:carapp/utils/api_contants.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:carapp/widget/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class CheckinContractController extends GetxController {
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

  Future<File?> resizeAndConvertToPng(File imageFile) async {
    try {
      // Read the image bytes
      final imageBytes = await imageFile.readAsBytes();

      // Decode the image using the image package
      final img.Image? decodedImage = img.decodeImage(imageBytes);
      if (decodedImage == null) return null;

      // Resize the image
      final img.Image resizedImage =
          img.copyResize(decodedImage, width: 800); // Adjust width as needed

      // Encode to PNG format
      final List<int> pngBytes = img.encodePng(resizedImage);

      // Save the resized PNG to a temporary file
      final tempDir = await getTemporaryDirectory();
      final resizedFile =
          File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png');
      await resizedFile.writeAsBytes(pngBytes);

      return resizedFile;
    } catch (e) {
      log("Error resizing image: $e");
      return null;
    }
  }

  Future<void> uploadCheckinContract(
      String name,
      String address,
      String postalCode,
      String email,
      String recordKilometers,
      String fuelLevel,
      String vehicleDamageComments,
      Rx<File?> signatureImage,
      BuildContext context) async {
    isLoading.value = true;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.checkinEndPoint),
    );

    request.headers.addAll({
      'Authorization': 'Bearer ${SharedPrefs.getToken}',
    });

    log("The token is : ${SharedPrefs.getToken}");

    request.fields['name'] = name;
    request.fields['address'] = address;
    request.fields['postal_code'] = postalCode;
    request.fields['email'] = email;
    request.fields['record_kilometers'] = recordKilometers;
    request.fields['fuel_level'] =
        (needleValue.value * 10.0) > 50.0 ? "full" : "half";
    request.fields['vehicle_damage_comments'] = vehicleDamageComments;

    log("The fields are : ");
    log(request.fields['name'].toString());
    log(request.fields['address'].toString());
    log(request.fields['postal_code'].toString());
    log(request.fields['email'].toString());
    log(request.fields['record_kilometers'].toString());
    log(request.fields['fuel_level'].toString());
    log(request.fields['vehicle_damage_comments'].toString());

    if (signatureImage.value != null) {
      // request.files.add(await http.MultipartFile.fromPath(
      //   'customer_signature',
      //   signatureImage.value!.path,
      // ));
      final resizedSignature =
          await resizeAndConvertToPng(signatureImage.value!);
      if (resizedSignature != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'customer_signature',
          resizedSignature.path,
        ));
      }
      log(resizedSignature!.path.toString());
    }

    if (licenceImage.value != null) {
      // request.files.add(await http.MultipartFile.fromPath(
      //   'license_photo',
      //   licenceImage.value!.path,
      // ));
      final resizedLicenceImage =
          await resizeAndConvertToPng(licenceImage.value!);
      if (resizedLicenceImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'license_photo',
          resizedLicenceImage.path,
        ));
      }
      log(resizedLicenceImage!.path.toString());
    }

    if (odometerImage.value != null) {
      // request.files.add(await http.MultipartFile.fromPath(
      //   'fuel_image',
      //   odometerImage.value!.path,
      // ));
      final resizedOdometerImage =
          await resizeAndConvertToPng(odometerImage.value!);
      if (resizedOdometerImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'fuel_image',
          resizedOdometerImage.path,
        ));
      }
      log(resizedOdometerImage!.path.toString());
    }

    if (vehicleImages[0] != null) {
      // request.files.add(await http.MultipartFile.fromPath(
      //   'vehicle_images[]',
      //   vehicleImages[0]!.path,
      // ));
      final resizedVehicleImage =
          await resizeAndConvertToPng(vehicleImages[0]!);
      if (resizedVehicleImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'vehicle_images[]',
          resizedVehicleImage.path,
        ));
      }
      log(resizedVehicleImage!.path.toString());
    }
    if (vehicleImages[1] != null) {
      // request.files.add(await http.MultipartFile.fromPath(
      //   'vehicle_images[]',
      //   vehicleImages[1]!.path,
      // ));
      final resizedVehicleImage =
          await resizeAndConvertToPng(vehicleImages[1]!);
      if (resizedVehicleImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'vehicle_images[]',
          resizedVehicleImage.path,
        ));
      }
      log(resizedVehicleImage!.path.toString());
    }

    try {
      var response = await request.send();
      statusCode.value = response.statusCode.toString();
      log(response.statusCode.toString());
      var responseBody = await response.stream.bytesToString();
      log("Response body: $responseBody");
      var jsonResponse = json.decode(responseBody);
      log("JSON response: $jsonResponse");
      if (response.statusCode == 201) {
        // var responseBody = await response.stream.bytesToString();
        // var jsonResponse = json.decode(responseBody);
        Get.offAll(
          const BottomNavigator(
            initialIndex: 2,
          ),
        );
        log("The response is : ${jsonResponse}");
        print("Contract id: ${jsonResponse['id']}");
        print('Check-in completed: ${jsonResponse['message']}');
        await SharedPrefs.setContractId(jsonResponse["data"]["id"]);
      }
    } catch (e) {
      log("The error is : $e");
      print('Error uploading contract: $e');
    } finally {
      isLoading.value = false;
      Get.back();
      if (statusCode.value == "201") {
        Get.snackbar("Success", "Check in form submitted.");
      } else {
        Get.snackbar("Failed", "Something went wrong.");
      }
    }
  }

  // void showDialogBox() {
  //   if (isLoading.value) {
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
