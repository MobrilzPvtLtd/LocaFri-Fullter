import 'package:carapp/ui/booking/login_screen.dart';
import 'package:carapp/ui/booking/user_booking_screen.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SharedPrefs.getUserEmail.isEmpty
        ? const LoginScreen()
        : const UserBookingScreen();
  }
}
