import 'dart:math';
import 'package:carapp/ui/cardetail/car_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Controllers/mobility/mobility_controller.dart';

class MobilityScreen extends StatelessWidget {
  final MobilityController mobilityController = Get.put(MobilityController());
  
  String formatDateTime(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd HH:mm').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Text(
              "All Cars ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  fontFamily: "UberMove"),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Obx(
        () {
          if (mobilityController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (mobilityController.carList.isEmpty) {
            return const Center(child: Text('No cars available'));
          }
          return ListView.builder(
            itemCount: mobilityController.carList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final product = mobilityController.carList[index];
              log(product["id"]);
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CarDetailScreen(product['id'])));
                },
                child: Container(
                  height: height * 0.18,
                  width: width * 0.50,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: const Color(0xffff36a21),
                            spreadRadius: 1,
                            blurStyle: BlurStyle.outer,
                            blurRadius: 1)
                      ]),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 5),
                        child: SizedBox(
                          height: height * 0.20,
                          width: width * 0.35,
                          child: Image.network(
                            product['profile'],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${product["name"]}",
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 18,
                              fontFamily: "UberMove",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "${product["Dprice"]}/day",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "UberMove",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                          Text(
                            product["location"],
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "UberMove",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            product["seat"],
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "UberMove",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.04,
                            width: width * 0.30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffff36a21),
                              border: Border.all(
                                width: 1,
                                color: const Color(0xffff36a21),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Detail',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontFamily: "UberMove",
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
