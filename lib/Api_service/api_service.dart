import 'dart:convert';
import 'dart:developer';
import "package:http/http.dart" as http;

class ApiService {
  String baseUrl = "http://locafri.ultimatetrueweb.com";
  Future<void> emailApiService(String email) async {
    String emailApibody = jsonEncode({"email": email});

    final response = await http.post(
      Uri.parse("$baseUrl/api/login"),
      headers: {"Content-Type": "application/json"},
      body: emailApibody,
    );
    if (response.statusCode == 200) {
      return;
    } else {
      log("Failed to send OTP");
      throw Exception('Failed to send OTP');
    }
  }

  Future<void> otpApiService(String email, String otp) async {
    String verifyOtpAPIBody = jsonEncode({"email": email, "otp": otp});

    final response = await http.post(
      Uri.parse("$baseUrl/api/verify-otp"),
      headers: {"Content-Type": "application/json"},
      body: verifyOtpAPIBody,
    );
    if (response.statusCode == 200) {
      return;
    } else {
      log("Failed to send OTP");
      throw Exception('Failed to send OTP');
    }
  }
}
