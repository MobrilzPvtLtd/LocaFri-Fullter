import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarDetailsController extends GetxController {
  // var isLoading = true.obs;
  // var carDetails = {}.obs;
  // var carDetails = {}.obs;
  // var imagesList = <String>[].obs;
  // var isLoading = true.obs;
  // Future<void> fetchCarDetails(int carId) async {
  //   try {
  //     isLoading(true);
  //     final response = await http.get(Uri.parse("https://locafri.ultimatetrueweb.com/api/cardetails/$carId"));
  //
  //     if (response.statusCode == 200) {
  //       carDetails.value = json.decode(response.body)['data'];
  //     } else {
  //       Get.snackbar("Error", "Failed to load car details");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Something went wrong");
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  // import 'package:get/get.dart';
  // import 'package:http/http.dart' as http;
  // import 'dart:convert';

  // class ProductDetailController extends GetxController {
  // var carDetails = {}.obs;
  // var imagesList = <String>[].obs;
  // var isLoading = true.obs;

  // Future<void> fetchCarDetails(int carId) async {
  // try {
  // isLoading(true);
  // final response = await http.get(
  // Uri.parse('https://locafri.ultimatetrueweb.com/api/cardetails/$carId'),
  // );
  //
  // if (response.statusCode == 200) {
  // final data = json.decode(response.body)['data'];
  // carDetails.value = data;
  //
  // // Parse the images from the API response
  // var images = json.decode(data['image']) as List<dynamic>;
  // imagesList.value = images.map((image) => 'https://locafri.ultimatetrueweb.com/$image').toList();
  // }
  // } catch (e) {
  // print("Error fetching car details: $e");
  // } finally {
  // isLoading(false);
  // }
  // }
  // class ProductDetailController extends GetxController {
  var carDetails = {}.obs;
  var imagesList = <String>[].obs;
  var isLoading = true.obs;

  Future<void> fetchCarDetails(int carId) async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://locafri.ultimatetrueweb.com/api/cardetails/$carId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        carDetails.value = data;
        // Check if the 'image' field is null or empty
        if (data['image'] != null && data['image'].isNotEmpty) {
          String imagesString = data['image'];
          var images = json.decode(imagesString) as List<dynamic>;
          imagesList.value = images
              .map((image) => 'https://locafri.ultimatetrueweb.com/$image')
              .toList();
        } else {
          // If 'image' is null or empty, just leave imagesList empty
          imagesList.clear();
        }
      }
    } catch (e) {
      print("Error fetching car details: $e");
    } finally {
      isLoading(false);
    }
  }
}

// }
