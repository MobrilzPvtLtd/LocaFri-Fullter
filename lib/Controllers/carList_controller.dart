import 'package:get/get.dart';
import 'dart:convert';
import "package:http/http.dart" as http;

class CarListController extends GetxController {
  var carList = [].obs; // Observable list to hold cars
  var isLoading = true.obs; // Loading state

  String baseUrl = "http://locafri.ultimatetrueweb.com";

  @override
  void onInit() {
    fetchCarList(); // Call API when controller is initialized
    super.onInit();
  }

  Future<void> fetchCarList() async {
    try {
      isLoading(true); // Show loading indicator
      final response = await http.get(
        Uri.parse("$baseUrl/api/cars"),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        carList.value = data['data']; // Assign the data array to carList
      } else {
        Get.snackbar("Error", "Failed to fetch car list");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false); // Hide loading indicator
    }
  }
}
