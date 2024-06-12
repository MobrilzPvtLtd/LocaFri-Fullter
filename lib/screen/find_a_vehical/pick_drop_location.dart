import 'package:flutter/material.dart';

class Pick_Drop_Location extends StatefulWidget {
  Pick_Drop_Location({super.key});

  @override
  State<Pick_Drop_Location> createState() => _Pick_Drop_LocationState();
}

class _Pick_Drop_LocationState extends State<Pick_Drop_Location> {
  String? selectedValue;

  String? _selectedValue;

  List<DropdownMenuItem<String>> get dropdownItems {
     List<DropdownMenuItem<String>> menuItems = [
        DropdownMenuItem(
          child:  Text("Romont Gare",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "UberMove",
                  fontWeight: FontWeight.w600)),
          value: "Romont Gare"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                const Text(
                  "Pick Up Location",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 25,
                    fontFamily: "UberMove",
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: width * 0.80,
                  child: DropdownButton<String>(
                    icon: Icon(
                      Icons.location_pin,
                      color: Colors.black,
                    ),
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
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "UberMove",
                            fontWeight: FontWeight.w700)),
                    isExpanded: true,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "UberMove"),
                  ),
                ),
              ],
            ),
          ),

          /// Drop Location Section
          ///
          Center(
            child: Column(
              children: [
                const Text(
                  "Drop Off Location",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 25,
                    fontFamily: "UberMove",
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: width * 0.80,
                  child: DropdownButton<String>(
                    icon: Icon(
                      Icons.location_pin,
                      color: Colors.black,
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
                            fontSize: 18,
                            fontFamily: "UberMove",
                            fontWeight: FontWeight.w600)),
                    isExpanded: true,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "UberMove"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
