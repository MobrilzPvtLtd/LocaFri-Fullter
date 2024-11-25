import 'dart:convert';
import 'dart:developer';
import 'package:carapp/models/privacy_policy_data_model.dart';
import 'package:carapp/utils/api_contants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PrivacyPolicyController extends GetxController {
  RxBool isLoading = false.obs;
  String? error;

  PrivacyPolicyDataModel? privacyPolicyDataModel;

  PrivacyPolicyDataModel? get privacyPolicyData => privacyPolicyDataModel;

  Future<void> fetchPrivacyPolicyData() async {
    isLoading.value = true;
    error = null;
    update();
    try {
      var response =
          await http.get(Uri.parse(ApiConstants.privacyPolicyEndPoint));
      log(response.body.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        privacyPolicyDataModel = PrivacyPolicyDataModel.fromJson(data);
        log(response.body.toString());
      }
    } catch (e) {
      error = 'Error : $e';
      log(error.toString());
    }
    isLoading.value = false;
    update();
  }
}
