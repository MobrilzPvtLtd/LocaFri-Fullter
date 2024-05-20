import 'package:flutter/material.dart';

class Carlist extends StatefulWidget {
  const Carlist({super.key});

  @override
  State<Carlist> createState() => _CarlistState();
}

class _CarlistState extends State<Carlist> {
  final List<Map<String, dynamic>> productlist = [
    {
      "name": "Tesla",
      "image": "assets/images/teslacar.png",
      "Price": "234",
      "Rating": "4.5",
    },
    {
      "name": "Farreri",
      "image": "assets/images/farrericar.png",
      "Price": "800",
      "Rating": "4.9",
    },
    {
      "name": "MG",
      "image": "assets/images/mgcars.png",
      "Price": "214",
      "Rating": "4.0",
    }
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height * 0.30,
      child: ListView.builder(
        itemCount: productlist.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final product = productlist[index];
          return Container(
            height: height * 0.75,
            width: width * 0.50,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 2,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      product["name"],
                      style:
                          const TextStyle(fontSize: 20,fontFamily: "PostsenOne"),
                    ),
                     Icon(Icons.favorite_outline_sharp,size: 25,)
                  ],
                ),
                Image.asset(product['image'],),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "\$${product["Price"]}/day",
                      style:
                          const TextStyle(fontSize: 20,fontFamily: "PostsenOne"),
                    ),
                   Text(
                      product["Rating"],
                      style:
                          const TextStyle(fontSize: 18,fontFamily: "PostsenOne"),
                    ),
                  ],
                ),
                      
              ],
            ),
          );
        },
      ),
    );
  }
}
