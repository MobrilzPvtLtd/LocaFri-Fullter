import 'package:flutter/material.dart';

class Customer_Detail_one extends StatefulWidget {
   Customer_Detail_one({super.key});

  @override
  State<Customer_Detail_one> createState() => _Customer_Detail_oneState();
}

class _Customer_Detail_oneState extends State<Customer_Detail_one> {
  List<String> item= ["Romont Gare"];

 String PickUpLocation ="Select Your Pickup Location";

 String DropOffLocation ="Select Your Drop Off Location";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DropdownButton(
              value: PickUpLocation,
              items: item.
              map<DropdownMenuItem<String>>((String value)=>DropdownMenuItem<String>
              (value: value,child: Text(value),)).toList(),
               onChanged: (newvalue) {
                 setState(() {
                   PickUpLocation = newvalue!;
                 });
               },)
          ],
        )),
    );
  }
}