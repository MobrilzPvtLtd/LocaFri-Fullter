import 'package:carapp/screen/Listof_cars/ListOfCar.dart';
import 'package:carapp/screen/auth/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class homewidget extends StatefulWidget {
  @override
  _homewidgetState createState() => _homewidgetState();
}

class _homewidgetState extends State<homewidget> {
  DateTime _pickUpDate = DateTime(2024, 6, 7);
  TimeOfDay _pickUpTime = TimeOfDay(hour: 17, minute: 0);
  DateTime _dropOffDate = DateTime(2024, 6, 14);
  TimeOfDay _dropOffTime = TimeOfDay(hour: 17, minute: 0);
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

  Future<void> _cupertinoDateTimePicker(BuildContext context, bool isPickUp) async {
    DateTime now = DateTime.now();
    DateTime initialDateTime = isPickUp ? _pickUpDate : _dropOffDate;

    if (initialDateTime.isBefore(now)) {
      initialDateTime = now;
    }

    DateTime? selectedDate;

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  onDateTimeChanged: (DateTime newDateTime) {
                    selectedDate = newDateTime;
                  },
                  initialDateTime: initialDateTime,
                  maximumDate: DateTime(2035),
                  minimumDate: now,
                  mode: CupertinoDatePickerMode.dateAndTime,
                ),
              ),
              CupertinoButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        if (isPickUp) {
          _pickUpDate = selectedDate!;
          _pickUpTime = TimeOfDay.fromDateTime(selectedDate!);
        } else {
          _dropOffDate = selectedDate!;
          _dropOffTime = TimeOfDay.fromDateTime(selectedDate!);
        }
      });
    }
  }

  Future<void> _cupertinoTimePicker(BuildContext context, bool isPickUp) async {
    DateTime now = DateTime.now();
    DateTime initialDateTime = isPickUp ? _pickUpDate : _dropOffDate;

    Duration initialTimerDuration = Duration(
      hours: initialDateTime.hour,
      minutes: initialDateTime.minute,
    );

    Duration? selectedDuration;

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoTimerPicker(
                  initialTimerDuration: initialTimerDuration,
                  mode: CupertinoTimerPickerMode.hm,
                  onTimerDurationChanged: (Duration newDuration) {
                    selectedDuration = newDuration;
                  },
                ),
              ),
              CupertinoButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );

    if (selectedDuration != null) {
      setState(() {
        DateTime updatedDateTime = isPickUp ? _pickUpDate : _dropOffDate;
        updatedDateTime = DateTime(
          updatedDateTime.year,
          updatedDateTime.month,
          updatedDateTime.day,
        ).add(selectedDuration!);
        
        if (isPickUp) {
          _pickUpDate = updatedDateTime;
          _pickUpTime = TimeOfDay.fromDateTime(updatedDateTime);
        } else {
          _dropOffDate = updatedDateTime;
          _dropOffTime = TimeOfDay.fromDateTime(updatedDateTime);
        }
      });
    }
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
          'assets/logo/Final-1.png',
          height: screenHeight * 0.06,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => Profile()));
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
              SizedBox(height: screenHeight * 0.02),
              Container(
                height: screenHeight * 0.45,
                width: screenWidth * 1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pick up office',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        fontFamily: "UberMove",
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.85,
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
                      width: screenWidth * 0.88,
                      child: _buildDateTimePicker(
                        context,
                        'Pick up day',
                        _pickUpDate,
                        'Pick up hour',
                        _pickUpTime,
                        true,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'Drop off office',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        fontFamily: "UberMove",
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.85,
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
                      width: screenWidth * 0.88,
                      child: _buildDateTimePicker(
                        context,
                        'Drop off day',
                        _dropOffDate,
                        'Drop off hour',
                        _dropOffTime,
                        false,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListOfCar()));
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
                      vertical: screenHeight * 0.02,
                    ),
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
    bool isPickUp,
  ) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                dateLabel,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: Text(
                timeLabel,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _cupertinoDateTimePicker(context, isPickUp),
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
                onTap: () => _cupertinoTimePicker(context, isPickUp),
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
