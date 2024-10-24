import 'package:carapp/utils/api_contants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarDetailsController extends GetxController {
  var carDetails = {}.obs;
  var imagesList = <String>[].obs;
  var isLoading = true.obs;

  Future<void> fetchCarDetails(int carId) async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('${ApiConstants.cardetailsEndPoint}/$carId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        carDetails.value = data;
        if (data['image'] != null && data['image'].isNotEmpty) {
          String imagesString = data['image'];
          var images = json.decode(imagesString) as List<dynamic>;
          imagesList.value = images
              .map((image) => '${ApiConstants.baseUrl}/$image')
              .toList();
        } else {
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
