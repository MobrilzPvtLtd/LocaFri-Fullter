import 'package:carapp/screen/Productdetails/productdetail.dart';
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
      "image": "assets/images/car8.png",
      "Price": "234",
      "Rating": "4.5",
    },
    {
      "name": "Farreri",
      "image": "assets/images/car5.png",
      "Price": "800",
      "Rating": "4.9",
    },
    {
      "name": "MG",
      "image": "assets/images/car4.png",
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
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Product_detail()));
            },
            child: Container(
              height: height * 0.78,
              width: width * 0.50,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[200],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120,
                        child: Text(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          product["name"],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: "UberMove",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      //  Icon(Icons.favorite_outline_sharp,size: 25,)
                      // Text("")
                    ],
                  ),
                  Image.asset(
                    product['image'],
                    fit: BoxFit.cover,
                    height: height * 0.20,
                    width: width * 0.45,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "\$${product["Price"]}/day",
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: "UberMove",
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        product["Rating"],
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: "UberMove",
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
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
