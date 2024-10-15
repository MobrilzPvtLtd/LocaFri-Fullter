// import 'package:carapp/screen/Listof_cars/cardetail_list.dart';
// import 'package:carapp/screen/Productdetails/productdetail.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../Controllers/carList_controller.dart';
//
// class ListOfCar extends StatefulWidget {
//   const ListOfCar({super.key});
//
//   @override
//   State<ListOfCar> createState() => _ListOfCarState();
// }
//
// class _ListOfCarState extends State<ListOfCar> {
//
//   final CarListController carListController = Get.put(CarListController());
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(
//                   Icons.arrow_back_ios,
//                   size: 30,
//                   color: Colors.black,
//                 )),
//             const Text(
//               "All Cars",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 30,
//                   fontWeight: FontWeight.w700,
//                   fontFamily: "UberMove"),
//             ),
//           ],
//         ),
//         // leading: const Text("hjghg"),
//         scrolledUnderElevation: 0,
//         elevation: 0,
//         // backgroundColor: Colors.white70,
//       ),
//       body: ListView.builder(
//         // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
//         itemCount: _Product_detail.productlist.length,
//         scrollDirection: Axis.vertical,
//         itemBuilder: (context, index) {
//           final product = _Product_detail.productlist[index];
//           return InkWell(
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => Product_detail()));
//             },
//             child: Container(
//               height: height * 0.18,
//               width: width * 0.50,
//               margin: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   shape: BoxShape.rectangle,
//                   color: Colors.white,
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Colors.black,
//                         spreadRadius: 1,
//                         blurStyle: BlurStyle.outer,
//                         blurRadius: 1)
//                   ]),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(product['image'],
//                       fit: BoxFit.cover,
//                       height: height * 0.20,
//                       width: width * 0.35),
//                   //
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,/
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 200,
//                             child: Text(
//                               product["name"],
//                               style: TextStyle(
//                                 overflow: TextOverflow.ellipsis,
//                                 fontSize: 25,
//                                 fontFamily: "UberMove",
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height * 0.02,
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           SizedBox(
//                             width: width * 0.01,
//                           ),
//                           Container(
//                             width: 100,
//                             child: Text(
//                               overflow: TextOverflow.ellipsis,
//                               "\$${product["Price"]}/day",
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontFamily: "UberMove",
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 product["Rating"],
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                   fontFamily: "UberMove",
//                                   fontWeight: FontWeight.w800,
//                                 ),
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.amber,
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                       const Text(
//                         "Avaliable Cars",
//                         style: TextStyle(
//                             color: Color(0xffff36a21),
//                             fontSize: 15,
//                             fontFamily: "UberMove"),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:carapp/screen/Productdetails/productdetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Controllers/carList_controller.dart';
import '../../Controllers/locationScreen_controller.dart';

class AllCarList extends StatelessWidget {
  final CarListController carListController = Get.put(CarListController());
  // final AvailableCarsController availableCarsController = Get.find();
  // final AvailableCarsController availableCarsController = Get.
  String formatDateTime(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd HH:mm').format(parsedDate);
  }
  @override
  Widget build(BuildContext context) {
    // final availableCars = availableCarsController.availableCars;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Row(
          children: [

            // IconButton(
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //     icon: const Icon(
            //       Icons.arrow_back_ios,
            //       size: 30,
            //       color: Colors.black,
            //     ),
            // ),

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
      body: Obx(() {
        if (carListController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator()); // Show loading
        }

        if (carListController.carList.isEmpty) {
          return const Center(
              child: Text('No cars available')); // Show if no data
        }
        return ListView.builder(
          // itemCount: availableCars.length,
          itemCount: carListController.carList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            // var product = availableCars[index];
            final product = carListController.carList[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Product_detail(product['id'])));
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
                          color: Color(0xffff36a21),
                          spreadRadius: 1,
                          blurStyle: BlurStyle.outer,
                          blurRadius: 1)
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Display car profile image
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 5),
                      child: Container(
                        height: height * 0.20,
                        width: width * 0.35,
                        child: Image.network(
                          product['profile'],
                          // fit: BoxFit.fill,
                          // height: height * 0.20,
                          // width: width * 0.30
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Car Name and Model
                        Text(
                          // "${product["name"]} (${product["model"]})",
                          "${product["name"]}",
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 18,
                            fontFamily: "UberMove",
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        // Text(
                        //   "(${product["model"]})",
                        //   style: const TextStyle(
                        //     overflow: TextOverflow.ellipsis,
                        //     fontSize: 18,
                        //     fontFamily: "UberMove",
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        // SizedBox(height: height * 0.02),

                        // Display car price per day (Dprice)
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
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: height * 0.04,
                          width: width * 0.30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffff36a21),
                            border: Border.all(width: 1, color: Color(0xffff36a21),),
                          ),
                          child: Center(
                              child: Text(
                                'Detail',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontFamily: "UberMove",
                                    fontWeight: FontWeight.w600),
                              )),
                        )

                        // Available features like "bluetooth", "sunroof"
                        // Text(
                        //   product["features"].join(','),
                        //   style: const TextStyle(
                        //
                        //       color: Colors.green,
                        //       fontSize: 15,
                        //       fontFamily: "UberMove"),
                        // ),

                        // Text(
                        //   "${formatDateTime(product['created_at'])}",
                        //   style: const TextStyle(
                        //     fontSize: 12,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        // Text(
                        //   "${formatDateTime(product['updated_at'])}",
                        //   style: const TextStyle(
                        //     fontSize: 12,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
