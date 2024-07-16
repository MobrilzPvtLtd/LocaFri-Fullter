import 'package:carapp/screen/auth/sign_in/sign_in.dart';
import 'package:carapp/screen/customer_detail/additional_options/Other_RequestWidget.dart';
import 'package:carapp/screen/customer_detail/additional_options/additional_options.dart';
import 'package:carapp/screen/customer_detail/additional_options/selectdays.dart';
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

  bool _AdditionalOption = false;

  bool AdditionalDriver = false;
  bool ChildBoosterSeat = false;
  bool ChildSeat = false;
  bool ExitPermit = false;
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
              fontSize: 30,
              color: Colors.black,
              fontFamily: "UberMove",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          minimum: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: "UberMove"),
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
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: "UberMove"),
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: "UberMove"),
                        hintText: "Email",
                        focusColor: Colors.white,
                        disabledBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                SizedBox(
                  width: width * 0.90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Select Additional Option",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Switch(
                        inactiveThumbColor: Colors.black,
                        activeColor: Color(0xffff36a21),
                        value: _AdditionalOption,
                        onChanged: (value) {
                          setState(() {
                            _AdditionalOption = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                _AdditionalOption ? AdditionalOptionWidget() : Container(),

                const SizedBox(
                  height: 20,
                ),

                /// this additional option to select the day and week and month
                /// this widget do select day and month week and how day,week and month  buy rental car
                const Selectdayoption(),

                const SizedBox(
                  height: 20,
                ),

                // this Pick and Drop location section

                /***
               * 
               * 
               * this section help you to select Pick and Drop location 
               * 
               * 
               * 
               */
                const Text(
                  "Pick Up Location",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "UberMove",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: width * 0.90,
                  child: DropdownButton<String>(
                    // elevation: 0,
                    isDense: false,
                    icon: const Icon(
                      Icons.arrow_outward,
                      color: Colors.amber,
                    ),
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                    items: dropdownItems,
                    hint: const Text("Select Your Pickup Location",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "UberMove")),
                    isExpanded: true,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "UberMove"),
                  ),
                ),
                const Text(
                  "Drop Off Location",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "UberMove",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: width * 0.90,
                  child: DropdownButton<String>(
                    icon: const Icon(
                      Icons.arrow_outward,
                      color: Colors.amber,
                    ),
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
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "UberMove")),
                    isExpanded: true,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "UberMove"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // Time And Date Picker Widget this widget
                //allow to customer selected car pick time and
                // car return time

                /***
               * 
               * 
               * this section help you to select Pick Day and Time and Drop Day Time 
               * 
               * 
               * 
               */

                const Customer_DateTime_Field(),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Sign_in()));
                  },
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.90,
                    decoration: BoxDecoration(
                      color: Color(0xffff36a21),

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
                          color: Colors.white),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          )),
    );
  }

  Widget AdditionalOptionWidget() {
    return Column(
      children: [
        additional_options(
            switchvalue: AdditionalDriver, text: "Additional Driver"),
        additional_options(
            switchvalue: ChildBoosterSeat, text: "Child Booster Seat"),
        additional_options(switchvalue: ChildSeat, text: "Child Seat"),
        additional_options(switchvalue: ExitPermit, text: "Exit Permit"),
        Other_RequestWidget(),
      ],
    );
  }
}
