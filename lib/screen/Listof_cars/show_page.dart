import 'package:carapp/screen/Listof_cars/cardetail_list.dart';
import 'package:carapp/screen/Productdetails/productdetail.dart';
import 'package:flutter/material.dart';

class ListOfCar extends StatefulWidget {
  const ListOfCar({super.key});

  @override
  State<ListOfCar> createState() => _ListOfCarState();
}

class _ListOfCarState extends State<ListOfCar> {
  final Product _Product_detail = Product();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            leading: const Text(""),
            scrolledUnderElevation: 0,
            elevation: 0,
              backgroundColor: Colors.white70,
              bottom: AppBar(
                leading: Text(""),
                leadingWidth: 0,
                // leading: IconButton(onPressed: (){
                //   Navigator.pop(context);
                // }, icon: const  Icon(Icons.arrow_back_ios,size: 30,color: Colors.black,)),
                scrolledUnderElevation: 0,
                title: const Text(
                  "All Cars",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontFamily: "UberMove"),
                ),
              ))),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _Product_detail.productlist.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final product = _Product_detail.productlist[index];
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Product_detail()));
            },
            child: Container(
              height: height * 0.60,
              width: width * 0.30,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 1,
                    blurStyle: BlurStyle.outer,
                    blurRadius: 1
                  )
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                //  const  SizedBox(
                //     height: 2,
                //   ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        product["name"],
                        style: const TextStyle(
                            fontSize: 20, fontFamily: "UberMove",fontWeight: FontWeight.w800,),
                      ),
                      Icon(
                        Icons.favorite_outline_sharp,
                        size: 25,
                      )
                    ],
                  ),
                  Image.asset(
                    product['image'],fit: BoxFit.cover,
                    height: height*0.14,
                    width: width*0.40
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "\$${product["Price"]}/day",
                        style: const TextStyle(
                            fontSize: 20, fontFamily: "UberMove",fontWeight: FontWeight.w800,),
                      ),
                      Text(
                        product["Rating"],
                        style: const TextStyle(
                            fontSize: 18, fontFamily: "UberMove",fontWeight: FontWeight.w800,),
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
