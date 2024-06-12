import 'package:carapp/screen/Listof_cars/ListOfCar.dart';
import 'package:carapp/screen/auth/Profile/profile.dart';
import 'package:carapp/screen/key_box/keybox.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime _pickUpDate = DateTime(2024, 6, 7);
  TimeOfDay _pickUpTime = TimeOfDay(hour: 17, minute: 0);
  DateTime _dropOffDate = DateTime(2024, 6, 14);
  TimeOfDay _dropOffTime = TimeOfDay(hour: 17, minute: 0);
  // String? _selectedPickUpLocation = 'Romont Gare';
  // String? _selectedDropOffLocation = 'Romont Gare';

  Future<void> _selectDate(BuildContext context, bool isPickUp) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isPickUp ? _pickUpDate : _dropOffDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        if (isPickUp) {
          _pickUpDate = picked;
        } else {
          _dropOffDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isPickUp) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isPickUp ? _pickUpTime : _dropOffTime,
    );
    if (picked != null) {
      setState(() {
        if (isPickUp) {
          _pickUpTime = picked;
        } else {
          _dropOffTime = picked;
        }
      });
    }
  }
   String? selectedValue;

  String? _selectedValue;

  List<DropdownMenuItem<String>> get dropdownItems {
    return [
      DropdownMenuItem(
        child: Text(
          "Romont Gare",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: "UberMove",
            fontWeight: FontWeight.w500,
          ),
        ),
        value: "Romont Gare",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/logo/Final-1.png', // Ensure you have this asset in your project
          height: screenHeight * 0.06,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black,size: 30,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> Profile()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Column(
              //     children: [
              //       Text(
              //         'SmartKey - connected car',
              //         style: TextStyle(
              //             fontSize: screenWidth * 0.05,
              //             fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(height: screenHeight * 0.01),
              //       Text(
              //         'Unlock the car using your mobile, with no need to go to the desk',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //             fontSize: screenWidth * 0.035,
              //             color: Colors.grey[700]),
              //       ),
              //       SizedBox(height: screenHeight * 0.01),
              //       ElevatedButton(
              //         onPressed: () {
              //           Navigator.push(context, MaterialPageRoute(builder: (_)=> KeyBox()));
              //         },
              //         child: Text(
              //           '+ More information',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontFamily: "UberMove",
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.orange,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(20),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                height: screenHeight * 0.45,
                width: screenWidth* 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pick up office',
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          fontFamily: "UberMove"),
                    ),
                    SizedBox(
                      width: screenWidth*0.85,
                      child: DropdownButton<String>(
                        icon: Icon(
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
                        hint: Text(
                          "Select Your Pickup Location",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045,
                            fontFamily: "UberMove",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        isExpanded: true,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.045,
                          fontFamily: "UberMove",
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(
                      width: screenWidth*0.88,
                        child: _buildDateTimePicker(context, 'Pick up day',
                            _pickUpDate, 'Pick up hour', _pickUpTime, true)),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'Drop off office',
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          fontFamily: "UberMove"),
                    ),
                    SizedBox(
                      width: screenWidth*0.85,
                      child: DropdownButton<String>(
                        icon: Icon(
                          Icons.arrow_outward,
                          color: Colors.amber,
                        ),
                        value: _selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedValue = newValue;
                          });
                        },
                        items: dropdownItems,
                        hint: Text(
                          "Select Your Drop-off Location",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045,
                            fontFamily: "UberMove",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        isExpanded: true,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.045,
                          fontFamily: "UberMove",
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(
                      width: screenWidth*0.88,
                      child: _buildDateTimePicker(context, 'Drop off day', _dropOffDate,
                          'Drop off hour', _dropOffTime, false),
                    ),
                  ],
                ),
              ),
             
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ListOfCar()));
                  },
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: "UberMove",
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.3,
                        vertical: screenHeight * 0.02),
                    textStyle: TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }

  Widget _buildDateTimePicker(
      BuildContext context,
      String dateLabel,
      DateTime dateValue,
      String timeLabel,
      TimeOfDay timeValue,
      bool isPickUp) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(dateLabel,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04))),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
                child: Text(timeLabel,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04))),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectDate(context, isPickUp),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(dateValue),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context, isPickUp),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    timeValue.format(context),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
