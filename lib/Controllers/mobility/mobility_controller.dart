import 'package:carapp/utils/api_contants.dart';
import 'package:get/get.dart';
import 'dart:convert';
import "package:http/http.dart" as http;

class MobilityController extends GetxController {
  var carList = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchCarList();
    super.onInit();
  }

  Future<void> fetchCarList() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(ApiConstants.allCarsEndPoint),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        carList.value = data['data']; 
      } else {
        Get.snackbar("Error", "Failed to fetch car list");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false); 
    }
  }
}
