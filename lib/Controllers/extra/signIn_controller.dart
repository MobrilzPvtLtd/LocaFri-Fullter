// import 'package:carapp/Api_service/api_service.dart';
// import 'package:get/get.dart';

// class SigninGetxController extends GetxController {
//   var email = "".obs;
//   var otp = "".obs;
//   var isVerified = false.obs;
//   final ApiService apiService = ApiService();

//   Future<bool> requestotp() async {
//     try {
//       await apiService.emailApiService(email.value);
//       Get.snackbar('Success', 'OTP sent to email');
//       return true;
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//       return false;
//     }
//   }

//     Future<bool> verifyOtp() async {
//     try {
//       await apiService.otpApiService(email.value, otp.value);
//       isVerified.value = true;
//       Get.snackbar('Success', 'OTP verified successfully');
//       return true; 
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//       return false;
//     }
//   }
// }
