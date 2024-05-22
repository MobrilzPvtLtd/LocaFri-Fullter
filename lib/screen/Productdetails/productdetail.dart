import 'dart:ui';

import 'package:carapp/screen/Productdetails/Specification_page.dart';
import 'package:carapp/widget/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Product_detail extends StatefulWidget {
  const Product_detail({super.key});

  @override
  State<Product_detail> createState() => _Product_detailState();
}

class _Product_detailState extends State<Product_detail> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        minimum: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  )),
              IconButton(
                  style: IconButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(2),
                          ),
                          side: BorderSide(color: Colors.black, width: 2))),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    size: 30,
                  ))
            ],
          ),
          Container(
            height: height * 0.35,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/farrericar.png")),
              // backgroundBlendMode: BlendMode.color
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Farreri Car",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w900),
              ),
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 30,
                  ),
                  label: const Text(
                    "4.9",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "\$499",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w900),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => const  Sign_in()));
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  height: height * 0.06,
                  width: width * 0.40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber[800]),
                  child: const Center(
                    child: Text(
                      "Rent",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "DMSans",
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Text(
            "Detail",
            style: TextStyle(
                fontSize: 30,
                fontFamily: "PlayfairDisplay",
                fontWeight: FontWeight.w800),
          ),
          Text(
            "The (car name) is the high-performance version of the 2 Series 2-door coupé. The first generation of the M2 is the F87 coupé and is powered by turbocharged.",
            style: TextStyle(fontSize: 20, color: Colors.grey[500]),
          ),
          const Divider(
            color: Colors.black45,
            endIndent: 40,
          ),
          SectionWidget(
              onpressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Specifications_page()));
              },
              fontWeight: FontWeight.w800,
              fontSize: 30,
              leadingText: "Specifications",
              ButtonText: "ViewsAll",
              FontFamily: "DMSans"),
          SizedBox(
            height: height * 0.20,
            width: width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(20),
                  height: height * 0.15,
                  width: width * 0.40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white60,
                      border: Border.all(
                        color: Colors.black38,
                        width: 2,
                      )),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Body",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w800)),
                      Text("Hatchback",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                );
              },
            ),
          )
        ]),
      ),
    ));
  }
}
