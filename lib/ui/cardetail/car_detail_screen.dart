import 'package:carapp/ui/customerdetail/customer_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/carDetails/car_details_controller.dart';

class CarDetailScreen extends StatelessWidget {
  final int carId;
  CarDetailScreen(this.carId, {super.key});
  final CarDetailsController controller = Get.put(CarDetailsController());
  final PageController _pageController = PageController();
  final RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    controller.fetchCarDetails(carId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Colors.black,
          ),
        ),
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              style: IconButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final carDetails = controller.carDetails;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15.0, bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.30,
                    child: Obx(
                      () {
                        if (controller.carDetails.isEmpty ||
                            controller.carDetails['images'] == null ||
                            controller.carDetails['images'].isEmpty) {
                          return const Center(
                              child: Text('Aucune image disponible'));
                        }
                        return PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.carDetails['images'].length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                currentIndex.value = index;
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                width: width * 0.90,
                                height: height * 0.30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        controller.carDetails['images'][index]),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            );
                          },
                          onPageChanged: (int index) {
                            currentIndex.value = index;
                          },
                        );
                      },
                    ),
                  ),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.carDetails['images'].length,
                        (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: currentIndex == index ? 14 : 8,
                            height: 4,
                            decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? Colors.orange
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            carDetails['name'],
                            style: const TextStyle(
                                fontSize: 25,
                                fontFamily: "UberMove",
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Text(
                                "2",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.thumb_up,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "2",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.thumb_down_alt_outlined,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.star,
                              color: const Color(0xffff36a21),
                              size: 25,
                            ),
                            label: const Text(
                              "4.9",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: "UberMove",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${carDetails['Dprice']} CHF par jour",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: const Color(0xffff36a21),
                                    fontFamily: "UberMove",
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${carDetails['wprice']} CHF par semaine",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: const Color(0xffff36a21),
                                    fontFamily: "UberMove",
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${carDetails['mprice']} CHF par mois",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: const Color(0xffff36a21),
                                    fontFamily: "UberMove",
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CustomerDetailScreen(
                                    vehicleName: carDetails['name'],
                                    dPrice: carDetails['Dprice'],
                                    mPrice: carDetails['mprice'],
                                    wPrice: carDetails['wprice'],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              height: height * 0.05,
                              width: width * 0.35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffff36a21),
                              ),
                              child: const Center(
                                child: Text(
                                  "Louer",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "UberMove",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    "Détails",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: "UberMove",
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    carDetails['desc'],
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[500],
                        fontFamily: "UberMove"),
                  ),
                  const Divider(
                    color: Colors.black45,
                    endIndent: 10,
                  ),
                  const Text(
                    "Caractéristiques",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: "UberMove"),
                  ),
                  Card(
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Modèle",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                // const Text(
                                //   "Taper",
                                //   style: TextStyle(
                                //       fontSize: 18,
                                //       fontFamily: "UberMove",
                                //       fontWeight: FontWeight.w500),
                                // ),
                                // const Text(
                                //   "Emplacement",
                                //   style: TextStyle(
                                //       fontSize: 18,
                                //       fontFamily: "UberMove",
                                //       fontWeight: FontWeight.w500),
                                // ),
                                const Text(
                                  "Siège",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                if (carDetails['door'] != null) ...{
                                  if (carDetails['door'] > 0) ...{
                                    const Text(
                                      "Porte",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "UberMove",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  },
                                },
                                const Text(
                                  "Transmission",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text(
                                  "Carburant",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text(
                                  "Kilomètre autorisé",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                // if (carDetails['permitted_kilometers_day'] !=
                                //         null &&
                                //     carDetails['permitted_kilometers_day'] !=
                                //         "") ...{
                                //   const Text(
                                //     "Kilomètre autorisé",
                                //     style: TextStyle(
                                //         fontSize: 18,
                                //         fontFamily: "UberMove",
                                //         fontWeight: FontWeight.w500),
                                //   ),
                                // },
                                // if (carDetails['permitted_kilometers_week'] !=
                                //         null &&
                                //     carDetails['permitted_kilometers_week'] !=
                                //         "") ...{
                                //   const Text(
                                //     "",
                                //     style: TextStyle(
                                //         fontSize: 18,
                                //         fontFamily: "UberMove",
                                //         fontWeight: FontWeight.w500),
                                //   ),
                                // },
                                // if (carDetails['permitted_kilometers_month'] !=
                                //         null &&
                                //     carDetails['permitted_kilometers_month'] !=
                                //         "") ...{
                                //   const Text(
                                //     "",
                                //     style: TextStyle(
                                //         fontSize: 18,
                                //         fontFamily: "UberMove",
                                //         fontWeight: FontWeight.w500),
                                //   ),
                                // },
                                const Text(
                                  "Bagage",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text(
                                  "Extérieur",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text(
                                  "Intérieur",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  carDetails['model'] ?? "None",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                // Text(
                                //   carDetails['type'] ?? "",
                                //   style: const TextStyle(
                                //       fontSize: 18,
                                //       fontFamily: "UberMove",
                                //       fontWeight: FontWeight.w500),
                                // ),
                                // Text(
                                //   carDetails['location'] ?? "",
                                //   style: const TextStyle(
                                //       fontSize: 18,
                                //       fontFamily: "UberMove",
                                //       fontWeight: FontWeight.w500),
                                // ),
                                Text(
                                  carDetails['seat'] ?? "",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                if (carDetails['door'] != null) ...{
                                  if (carDetails['door'] > 0) ...{
                                    Text(
                                      carDetails['door'].toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: "UberMove",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  },
                                },
                                Text(
                                  carDetails['trans'] ?? "",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  carDetails['fuel'] ?? "",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  carDetails['mitter'] ?? "",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                // if (carDetails['permitted_kilometers_day'] !=
                                //         null &&
                                //     carDetails['permitted_kilometers_day'] !=
                                //         "") ...{
                                //   Text(
                                //     "${carDetails['permitted_kilometers_day']} / 1 day",
                                //     style: const TextStyle(
                                //         fontSize: 18,
                                //         fontFamily: "UberMove",
                                //         fontWeight: FontWeight.w500),
                                //   ),
                                // },
                                // if (carDetails['permitted_kilometers_week'] !=
                                //         null &&
                                //     carDetails['permitted_kilometers_week'] !=
                                //         "") ...{
                                //   Text(
                                //     "${carDetails['permitted_kilometers_week']} / 1 week",
                                //     style: const TextStyle(
                                //         fontSize: 18,
                                //         fontFamily: "UberMove",
                                //         fontWeight: FontWeight.w500),
                                //   ),
                                // },
                                // if (carDetails['permitted_kilometers_month'] !=
                                //         null &&
                                //     carDetails['permitted_kilometers_month'] !=
                                //         "") ...{
                                //   Text(
                                //     "${carDetails['permitted_kilometers_month']} / 1 month",
                                //     style: const TextStyle(
                                //         fontSize: 18,
                                //         fontFamily: "UberMove",
                                //         fontWeight: FontWeight.w500),
                                //   ),
                                // },
                                Text(
                                  carDetails['luggage'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  carDetails['exterior'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  carDetails['interior'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Caractéristiques",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "UberMove",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.06,
                    child: carDetails["features"] != null &&
                            carDetails["features"].isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: carDetails["features"].length,
                            itemBuilder: (context, index) {
                              var details = carDetails["features"];
                              return Container(
                                margin: EdgeInsets.only(right: width * 0.02),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white60,
                                  border: Border.all(
                                    color: const Color(0xffff36a21),
                                    width: 1.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    details[index],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: "UberMove",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text('Aucune fonctionnalité disponible'),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
