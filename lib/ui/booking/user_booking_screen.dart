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

  @override
  void initState() {
    super.initState();
    controller.fetchUserBookingData().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Booking History"),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchUserBookingData();
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.error.value != null) {
                return Center(
                  child: Text(
                    "Error: ${controller.error.value}",
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                );
              } else if (controller.bookingData!.isNotEmpty) {
                return ListView.builder(
                  itemCount: controller.bookingData!.length,
                  itemBuilder: (context, index) {
                    final booking = controller.bookingData?[index].bookings;
                    final transaction =
                        controller.bookingData![index].remainingAmount;
                    double transactionAmount =
                        double.tryParse(transaction!) ?? 0.0;
                    print('Transaction Amount: $transactionAmount');
                    String formattedAmount =
                        transactionAmount.toStringAsFixed(2);

                    String status;
                    Color color;

                    if (booking!.isComplete == 1 && booking.isConfirm == 2) {
                      status = "Completed";
                      color = Colors.blue;
                    } else if (booking.isViewbooking == 1 &&
                        booking.isRejected == 0 &&
                        booking.isContract == 0 &&
                        booking.isConfirm == 0 &&
                        booking.isComplete == 0 &&
                        booking.seen == 1) {
                      status = "Reservation Accepted";
                      color = Colors.yellow.shade700;
                    } else if (booking.isViewbooking == 1 &&
                        booking.isRejected == 0 &&
                        booking.isContract == 1 &&
                        booking.isConfirm == 0 &&
                        booking.isComplete == 0 &&
                        booking.seen == 1) {
                      status = "Check-in";
                      color = Colors.green;
                    } else if (booking.isViewbooking == 1 &&
                        booking.isRejected == 0 &&
                        booking.isContract == 2 &&
                        booking.isConfirm == 0 &&
                        booking.isComplete == 0 &&
                        booking.seen == 1) {
                      status = "Check-in submitted";
                      color = Colors.green;
                    } else if (booking.isViewbooking == 1 &&
                        booking.isRejected == 0 &&
                        booking.isContract == 2 &&
                        booking.isConfirm == 1 &&
                        booking.isComplete == 0 &&
                        booking.seen == 1) {
                      status = "Check-out";
                      color = Colors.green;
                    } else if (booking.isViewbooking == 1 &&
                        booking.isRejected == 0 &&
                        booking.isContract == 2 &&
                        booking.isConfirm == 2 &&
                        booking.isComplete == 0 &&
                        booking.seen == 1) {
                      status = "Check-out submitted";
                      color = Colors.green;
                    } else if (booking.isViewbooking == 1 &&
                        booking.isContract == 2 &&
                        booking.isConfirm == 2 &&
                        booking.seen == 1 &&
                        booking.isComplete == 0) {
                      status = "Completed";
                      color = Colors.green;
                    } else if (booking.isViewbooking == 1 &&
                        booking.isRejected == 0 &&
                        booking.isContract == 2 &&
                        booking.isConfirm == 0 &&
                        booking.seen == 1 &&
                        booking.isComplete == 1) {
                      status = "success";
                      color = Colors.green;
                    } else if (booking.isRejected == 1) {
                      status = "Rejected";
                      color = Colors.red;
                    } else {
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
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    booking.name.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (booking.isComplete == 1 &&
                                      booking.isConfirm == 2) {
                                    return;
                                  } else if (booking.isContract == 2 &&
                                      booking.isConfirm == 1) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CheckoutContractScreen(
                                          contractId: controller
                                                  .bookingData?[index]
                                                  .contractId ??
                                              0,
                                          vehicleName: booking.name ?? "",
                                          price: formattedAmount ?? "",
                                          id: booking.id ?? 0,
                                          paymentStatus:
                                              booking.status.toString(),
                                          pendingAmount: transactionAmount,
                                          name:
                                              "${booking.checkout?.firstName ?? ""} ${booking.checkout?.lastName ?? ""}",
                                          email: booking.checkout?.email
                                                  .toString() ??
                                              "",
                                          address:
                                              booking.checkout?.addressFirst ??
                                                  "",
                                          zipCode:
                                              booking.checkout?.zipCode ?? "",
                                        ),
                                      ),
                                    );
                                  } else if (booking.isContract == 1) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CheckinContractScreen(
                                          id: booking.id ?? 0,
                                          name:
                                              "${booking.checkout?.firstName ?? ""} ${booking.checkout?.lastName ?? ""}",
                                          email: booking.checkout?.email
                                                  .toString() ??
                                              "",
                                          address:
                                              booking.checkout?.addressFirst ??
                                                  "",
                                          zipCode:
                                              booking.checkout?.zipCode ?? "",
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: color,
                                  ),
                                  child: Text(
                                    status, // Computed status
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
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Text(
                                booking.totalPrice.toString(),
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (transaction != null) ...{
                            Row(
                              children: [
                                const Text(
                                  "Pending Price: ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  transaction,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          },
                          Row(
                            children: [
                              const Text(
                                "Location: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Flexible(
                                child: Text(
                                  "${booking.pickUpLocation ?? ""} to ${booking.dropOffLocation ?? ""}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                "Date: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Text(
                                "${formatDate(booking.pickUpDate.toString())} to ${formatDate(booking.collectionDate.toString())}",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
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
          ),
        ));
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return "${dateTime.day}-${dateTime.month}-${dateTime.year}";
  }
}
