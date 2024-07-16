import 'package:carapp/screen/Listof_cars/cardetail_list.dart';
import 'package:carapp/screen/Listof_cars/ListOfCar.dart';
import 'package:carapp/screen/auth/Profile/profile.dart';
import 'package:carapp/screen/find_a_vehical/find_a_vehical.dart';
import 'package:carapp/screen/home/carlist.dart';
import 'package:carapp/screen/pickdate_time/date_time.dart';
import 'package:carapp/screen/whistlist/whistlist.dart';
import 'package:carapp/widget/bottomnavigationbar.dart';
import 'package:carapp/widget/categories.dart';
import 'package:carapp/widget/homewidget.dart';
import 'package:carapp/widget/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List images = [
    "assets/images/categories/tesla.png",
    "assets/images/categories/mitsubishi.png",
    "assets/images/categories/mg.png",
    "assets/images/categories/ferrari.png",
    "assets/images/categories/bmw.png"
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // bottomNavigationBar: BottomNav(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(05),
        child: AppBar(
          backgroundColor: Colors.transparent,
        ),
      ),
      backgroundColor: Colors.grey[100],
      extendBodyBehindAppBar: true,
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topAppbar(),
              const SizedBox(
                height: 20,
              ),
              const Date_Time_Picker(),
              // Find_A_Vehical(),
              // // Brands Categories Section
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     const Text(
              //       "Brands",
              //       style: TextStyle(
              //         fontWeight: FontWeight.w800,
              //         fontSize: 20,fontFamily: "UberMove"),
              //     ),
              //     const SizedBox(
              //       height: 20,
              //     ),
              //     SizedBox(
              //       height: 100,
              //       child: ListView.builder(
              //         shrinkWrap: true,
              //         scrollDirection: Axis.horizontal,
              //         itemCount: 5,
              //         itemBuilder: (context, index) {
              //           return Column(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               SizedBox(
              //                 height: 80,
              //                 width: 100,
              //                 child:
              //                     Categories(image: images[index], ontap: () {}),
              //               )
              //             ],
              //           );
              //         },
              //       ),
              //     )
              //   ],
              // ),
              SizedBox(
                height: 20,
              ),
              SectionWidget(
                onpressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListOfCar()));
                },
                fontSize: 20,
                leadingText: "Avaliable Cars",
                ButtonText: "More",
                FontFamily: "UberMove",
                fontWeight: FontWeight.w800,
              ),
              //  const  SizedBox(height: 20,),

              // Carlist this list store all cars
              const Carlist(),

              // const SizedBox(height: 10,),
              // const SectionWidget(leadingText: "PROMO",fontSize: 20, ButtonText: "",FontFamily: "UberMove",fontWeight: FontWeight.w800,),
              // Container(
              //   height: height*0.25 ,
              //   width: width*0.90,
              //   margin: EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     color: Colors.grey[200],
              //     borderRadius: BorderRadius.circular(20),
              //     // image: DecorationImage(image: AssetImage("assets/images/car8.png",),)
              //   ),
              //   child:Image.asset("assets/images/car4.png",fit: BoxFit.contain,
              //     height: height*0.30,
              //     width: width*0.30,),

              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget topAppbar() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: height * 0.08,
          width: width * 0.25,
          decoration: BoxDecoration(
              // color: Colors.black,
              image: DecorationImage(
            image: AssetImage("assets/logo/Final-1.png"),
            fit: BoxFit.cover,
          )),
        ),
        // Image.asset(
        //           "assets/logo/Final-1.png",
        //           height: 50,
        //         ),

        const SizedBox(
          height: 0,
        ),
        // const   Icon(
        //     Icons.search_outlined,
        //     color: Color(0xffff36a21),

        //     size: 40,
        //   ),
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile()));
          },
          child: const CircleAvatar(
            backgroundImage: AssetImage("assets/images/person.jpg"),
            radius: 25,
          ),
        )
      ],
    );
  }
}
