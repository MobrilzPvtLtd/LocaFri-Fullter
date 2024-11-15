import 'package:carapp/Controllers/booking/booking_controller.dart';
import 'package:flutter/material.dart';

class UserBookingScreen extends StatefulWidget {
  const UserBookingScreen({super.key});

  @override
  State<UserBookingScreen> createState() => _UserBookingScreenState();
}

class _UserBookingScreenState extends State<UserBookingScreen> {
  final BookingController controller = BookingController();

  @override
  void initState() {
    controller.fetchUserBookingData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking History"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(),
      ),
    );
  }
}
