import 'package:carapp/Api_service/api_service.dart';
import 'package:carapp/screen/contract/checkin_contract.dart';
import 'package:get/get.dart';

class SigninGetxController extends GetxController {
  var email = "".obs;
  var otp = "".obs;
  var isVerified = false.obs;
  final ApiService apiService = ApiService();

  Future<void> requestotp() async {
    try {
      await apiService.emailApiService(email.value);
      Get.snackbar('Success', 'OTP sent to email');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> verfiyotp() async {
    try {
      await apiService.otpApiService(email.value, otp.value);
      isVerified.value = true;
      Get.to(checkin_contract());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
