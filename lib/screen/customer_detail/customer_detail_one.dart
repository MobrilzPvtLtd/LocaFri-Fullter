import 'package:carapp/screen/customer_detail/customer_datetime_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Customer_Detail_one extends StatefulWidget {
  Customer_Detail_one({super.key});

  @override
  State<Customer_Detail_one> createState() => _Customer_Detail_oneState();
}

class _Customer_Detail_oneState extends State<Customer_Detail_one> {
  String? selectedValue;
  String? _selectedValue;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Romont Gare"), value: "Romont Gare"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            )),
        title: const Text(
          "Detail Form",
          style: TextStyle(
              fontSize: 30, color: Colors.black, fontFamily: "UberMove",fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(10),
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "Full Name ",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "Phone Number",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            const Text(
              "Pick Up Location",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: "UberMove",
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 55,
              width: width * 0.70,
              child: DropdownButton<String>(
                // elevation: 0,
                isDense: false,

                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                items: dropdownItems,
                hint: const Text("Select Your Pickup Location",
                    style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: "UberMove")),
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 18,fontFamily: "UberMove"),
              ),
            ),
            const Text(
              "Drop Off Location",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: "UberMove",
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 55,
              width: width * 0.70,
              child: DropdownButton<String>(
                // elevation: 0,
                isDense: false,

                value: _selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                },
                items: dropdownItems,
                hint: const Text("Select Your Drop Off Location",
                    style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: "UberMove")),
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 18,fontFamily: "UberMove"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // Time And Date Picker Widget this widget
            //allow to customer selected car pick time and
            // car return time

            const Customer_DateTime_Field(),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: height * 0.08,
                width: width * 0.90,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(color: Colors.black, width: 2)
                    ),
                child: const Center(
                    child: Text(
                  "SUBMIT FORM",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: "UberMove",
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                )),
              ),
            )
          ],
        ),
      )),
    );
  }
}
