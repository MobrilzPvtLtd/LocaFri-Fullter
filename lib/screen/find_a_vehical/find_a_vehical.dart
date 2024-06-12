import 'package:carapp/screen/Listof_cars/ListOfCar.dart';
import 'package:carapp/screen/find_a_vehical/pick_drop_date.dart';
import 'package:carapp/screen/find_a_vehical/pick_drop_location.dart';
import 'package:carapp/screen/home/carlist.dart';
import 'package:flutter/material.dart';

class Find_A_Vehical extends StatefulWidget {
  const Find_A_Vehical({super.key});

  @override
  State<Find_A_Vehical> createState() => _Find_A_VehicalState();
}

class _Find_A_VehicalState extends State<Find_A_Vehical> {
  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  Column(
      children: [
        Divider(height: 5,),
        Pick_Drop_Location(),
       const  SizedBox(height: 20,),
       const  Pick_Drop_Date(),
       GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) =>   ListOfCar()));
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                height: height * 0.06,
                width: width * 0.60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const  Color(0xffff36a21),),
                child: const Center(
                  child: Text(
                    "Find Vehical",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "UberMove",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Divider(height: 5,)
      ],
    );
  }
}