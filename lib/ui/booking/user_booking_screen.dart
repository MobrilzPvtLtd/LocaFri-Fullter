import 'package:carapp/Controllers/booking/booking_controller.dart';
import 'package:carapp/ui/checkin/checkin_contract_screen.dart';
import 'package:carapp/ui/checkout/checkout_contract_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserBookingScreen extends StatefulWidget {
  const UserBookingScreen({super.key});

  @override
  State<UserBookingScreen> createState() => _UserBookingScreenState();
}

class _UserBookingScreenState extends State<UserBookingScreen> {
  final BookingController controller = Get.put(BookingController());
  String? status;
  Color? color;

  String foramtDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }

  // @override
  // void initState() {
  //   controller.fetchUserBookingData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    controller.fetchUserBookingData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Booking History"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GetBuilder<BookingController>(builder: (context) {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.error != null) {
            return Center(
              child: Text("Error: ${controller.error}"),
            );
          } else if (controller.bookingData != null && controller.bookingData!.isNotEmpty) {
            final data = controller.bookingData;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                final booking = data[index].booking;
                final transaction = booking!.transaction;

                // Initialize status and color
                String status;
                Color color;

                if (booking.isComplete == 1 && booking.isConfirm == 2) {
                  // Completed
                  status = "Completed";
                  color = Colors.blue;
                } else if (booking.isContract == 2 && booking.isConfirm == 1) {
                  // Check-out
                  status = "Check-out";
                  color = Colors.green;
                } else if (booking.isContract == 1) {
                  // Check-in
                  status = "Check-in";
                  color = Colors.green;
                } else if (booking.isViewbooking == 1) {
                  // Check-in (if is_viewbooking turns to 1)
                  status = "Check-in";
                  color = Colors.green;
                } else {
                  // Default Pending State
                  status = "Pending";
                  color = Colors.red;
                }
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: Text(
                                    booking.id.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                booking.name.toString(),
                                style: const TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate based on computed status
                              if (booking.isComplete == 1 && booking.isConfirm == 2) {
                                // Booking Completed — No navigation or show details
                                return;  // Optional: You might show a dialog or summary instead
                              } else if (booking.isContract == 2 && booking.isConfirm == 1) {
                                // Navigate to CheckoutContractScreen
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutContractScreen(
                                        vehicleName:booking.name,
                                        dPrice:booking.dprice,
                                        id:booking.id,
                                        paymentStatus: booking.status.toString(),
                                    ),
                                  ),
                                );
                              } else if (booking.isContract == 1 || booking.isViewbooking == 1) {
                                // Navigate to CheckinContractScreen
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckinContractScreen(id:booking.id),
                                  ),
                                );
                              }
                              // Optional: Add a default action or an alert for unsupported states
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: color,  // Determined by your status logic
                              ),
                              child: Text(
                                status,  // Computed status
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            "Total Price: ",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            booking.totalPrice.toString(),
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (transaction != null) ...{
                        Row(
                          children: [
                            const Text(
                              "Pending Price: ",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              "${double.parse(booking.totalPrice.toString()) - double.parse(transaction.amount.toString())}",
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      },
                      Row(
                        children: [
                          const Text(
                            "Location: ",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            "${booking.pickUpLocation} to ${booking.dropOffLocation}",
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            "Date: ",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            "${formatDate(booking.pickUpDate.toString())} to ${formatDate(booking.collectionDate.toString())}",
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            "Status: ",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            booking.status.toString(),
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                "No Booking Available",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            );
          }
        }),
      )

    );
  }
  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return "${dateTime.day}-${dateTime.month}-${dateTime.year}";
  }
}
