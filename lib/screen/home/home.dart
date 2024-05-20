import 'package:carapp/screen/home/carlist.dart';
import 'package:carapp/widget/categories.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        unselectedItemColor: Colors.white,
        elevation: 0,
        items: const [
        BottomNavigationBarItem(
         backgroundColor: Colors.black, icon: Icon(Icons.home_filled,),label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.favorite),label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.place_outlined),label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.notifications,),label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person,),label: ""),
      ]),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: AppBar(),
      ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        minimum: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topAppbar(),
              const SizedBox(
                height: 20,
              ),
          
              // Brands Categories Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Brands",
                    style: TextStyle(fontSize: 20,fontFamily: "PostsenOne"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 80,
                              width: 100,
                              child:
                                  Categories(image: images[index], ontap: () {}),
                            )
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
              const SectionWidget(
                leadingText: "Avaliable Cars",
                ButtonText: "More",
              ),
             const  SizedBox(height: 20,),
          
             // Carlist this list store all cars 
             const  Carlist( ),
              const SizedBox(height: 10,),
              const SectionWidget(leadingText: "PROMO", ButtonText: ""),
              Container(
                height: height*0.20 ,
                width: width*0.90,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(image: AssetImage("assets/images/farrericar.png"))
                ),
          
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget topAppbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.place_outlined,
          color: Colors.amber[600],
          size: 30,
        ),
        const Text(
          "Your Location\nMumbai,Thane",
          style: TextStyle(
              fontSize: 20,
              fontFamily: "PostsenOne"),
        ),
        const SizedBox(
          height: 40,
        ),
        Icon(
          Icons.search_outlined,
          color: Colors.amber[600],
          size: 40,
        ),
        const CircleAvatar(
          backgroundImage: AssetImage("assets/images/person.jpg"),
          radius: 30,
        )
      ],
    );
  }
}
