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
    controller.fetchUserBookingData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Text("Error : ${controller.error}"),
            );
          } else if (controller.bookingData != null &&
              controller.bookingData!.length != 0) {
            final data = controller.bookingData;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                switch (data[index].statusDescription) {
                  case "pending":
                    status = "Pending";
                    color = Colors.red;
                    break;
                  case "Rejected ":
                    status = "Rejected";
                    color = Colors.red;
                    break;
                  case " submit Check-in":
                    status = "Check-in";
                    color = Colors.green;
                    break;
                  case "Check-in submitted ":
                    status = "Check-out";
                    color = Colors.green;
                    break;
                  case "Booking is yet to approve":
                    status = "Not Approved";
                    color = Colors.green;
                    break;
                  default:
                    status = "Completed";
                    color = Colors.red;
                }
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 180,
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
                                    data[index].bookingId.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                data[index].vehicleName.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              switch (data[index].statusDescription) {
                                case "Rejected ":
                                  break;
                                case " submit Check-in":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CheckinContractScreen(),
                                    ),
                                  );
                                  break;
                                case "Check-in submitted ":
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CheckoutContractScreen(
                                        paymentStatus:
                                            data[index].status.toString(),
                                      ),
                                    ),
                                  );
                                default:
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: color,
                              ),
                              child: Text(
                                status ?? "Pending",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Price : ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            data[index].totalPrice.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Location : ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "${data[index].pickUpLocation.toString()} to ${data[index].dropOffLocation.toString()}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Date : ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "${foramtDate(data[index].pickUpDate.toString())} to ${foramtDate(data[index].collectionDate.toString())}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
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
    );
  }
}
