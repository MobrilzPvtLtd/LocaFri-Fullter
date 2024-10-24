import 'package:carapp/utils/api_contants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../ui/mobility/search_cars.dart';

class SearchCarsController extends GetxController {
  var locations = <String>[].obs;
  var availableCars = [].obs;
  var pickUpLocationValue = ''.obs;
  var selectedValue1 = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchLocations();
    super.onInit();
  }

  void fetchLocations() async {
    try {
      isLoading(true);
      var response = await http
          .get(Uri.parse(ApiConstants.allCarsEndPoint));
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];

        locations.assignAll(data
            .map<String>((car) => car['location'].toString())
            .toSet()
            .toList());
      } else {
        Get.snackbar("Error", "Failed to fetch locations");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchAvailableCars(
      String pickUpLocation, String pickUpDateAndTime) async {
    try {
      isLoading(true);

      var body = {
        "location": pickUpLocation,
        "available_time": pickUpDateAndTime, 
      };

      var response = await http.post(
        Uri.parse(ApiConstants.availableCarsEndPoint),
        body: body,
      );
      
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        availableCars.assignAll(data['data']);
        Get.snackbar("Success", "Cars fetched successfully!");
        Get.to(() => SearchCars());
      } else {
        Get.snackbar("Error", "Failed to fetch available cars");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

}
