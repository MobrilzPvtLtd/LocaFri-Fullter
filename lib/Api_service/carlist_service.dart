import 'dart:convert';
import "package:http/http.dart" as http;


class CarListApi{
  String baseUrl = "http://locafri.ultimatetrueweb.com";
  Future<void> carApiService(String email) async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/cars"),
        );
    if (response.statusCode == 200) {
      return;
    }
  }

}