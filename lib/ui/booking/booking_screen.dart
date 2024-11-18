import 'package:carapp/ui/booking/login_screen.dart';
import 'package:carapp/ui/booking/user_booking_screen.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  var screen;

  @override
  void initState() {
    screen = SharedPrefs.getUserEmail.isEmpty
        ? const LoginScreen()
        : const UserBookingScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return screen;
  }
}
