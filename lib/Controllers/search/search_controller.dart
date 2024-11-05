import 'package:carapp/utils/api_contants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../ui/mobility/search_cars.dart';

class SearchCarsController extends GetxController {
  var locations = <String>[].obs;
  var availableCars = [].obs;
  var pickUpLocationValue = ''.obs;
  var dropOffLocationValue = ''.obs;
  var isLoading = true.obs;
  var pickUpDate = ''.obs;
  var pickUpTime = ''.obs;
  var dropOffDate = ''.obs;
  var dropOffTime = ''.obs;
  var pickUpDateAndTime = DateTime.now().obs;
  var dropOfDateAndTime = DateTime.now().obs;

  @override
  void onInit() {
    fetchLocations();
    super.onInit();
  }

  void fetchLocations() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(ApiConstants.allCarsEndPoint));
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

  Future<void> fetchAvailableCars(String pickUpLocation,
      String pickUpDateAndTime, String dropOfDateAndTime) async {
    try {
      isLoading(true);

      var body = {
        "location": pickUpLocation,
        "available_time": pickUpDateAndTime,
      };

      pickUpDate.value = formatDate(pickUpDateAndTime); 
      pickUpTime.value = formatTime(pickUpDateAndTime); 
      dropOffDate.value = formatDate(dropOfDateAndTime); 
      dropOffTime.value = formatTime(dropOfDateAndTime); 

      var response = await http.get(
        Uri.parse(ApiConstants.allCarsEndPoint),
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

  String formatDate(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr); 

    String formattedDate = '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year}';
    return formattedDate; 
  }

  String formatTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);

    String formattedTime =
        '${dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12}:'
        '${dateTime.minute.toString().padLeft(2, '0')} '
        '${dateTime.hour >= 12 ? 'PM' : 'AM'}';

    return formattedTime; 

  }

}
