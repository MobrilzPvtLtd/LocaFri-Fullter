import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../screen/Listof_cars/ListOfCar.dart';

class AvailableCarsController  extends GetxController {
  var locations = <String>[].obs;
  var availableCars = [].obs;  // Observable list for dropdown items
  var selectedValue = ''.obs;
  var selectedValue1 = ''.obs;// Selected value in dropdown
  var isLoading = true.obs;

  // var isLoading = false.obs;
  // var availableCars = [].obs;

  // Loading state
  // RxBool isLoading = false.obs;
  @override
  void onInit() {
    fetchLocations();
    super.onInit();
  }

  // void fetchLocations() async {
  //   try {
  //     isLoading(true);
  //     var response = await http.get(Uri.parse('http://locafri.ultimatetrueweb.com/api/cars'));
  //     if (response.statusCode == 200) {
  //       var data = json.decode(response.body)['data'];
  //       // Extract and add unique locations to the dropdown list
  //       locations.assignAll(data.map<String>((car) => car['location']).toSet().toList());
  //     } else {
  //       Get.snackbar("Error", "Failed to fetch locations");
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  void fetchLocations() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('http://locafri.ultimatetrueweb.com/api/cars'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];
        // Ensure that each location is cast to String
        locations.assignAll(data.map<String>((car) => car['location'].toString()).toSet().toList());
      } else {
        Get.snackbar("Error", "Failed to fetch locations");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchAvailableCars(String location, String availability) async {
    try {
      isLoading(true);

      // API body
      var body = {
        "location": location,
        "available": availability,
      };

      var response = await http.post(
        Uri.parse('http://locafri.ultimatetrueweb.com/api/avalibalcars'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        print('AvailbaleCar${data}');
        availableCars.assignAll(data['data']);
        Get.snackbar("Success", "Cars fetched successfully!");
        Get.to(() => ListOfCar());
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
