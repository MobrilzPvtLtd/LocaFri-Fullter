import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Customer_DateTime_Field extends StatefulWidget {
  const Customer_DateTime_Field({super.key});

  @override
  State<Customer_DateTime_Field> createState() =>
      _Customer_DateTime_FieldState();
}

class _Customer_DateTime_FieldState extends State<Customer_DateTime_Field> {
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

  Future<void> _cupertinoDateTimePicker(
      BuildContext context, bool isPickUp) async {
    DateTime now = DateTime.now();
    DateTime initialDateTime = isPickUp ? _pickUpDate : _dropOffDate;

    if (initialDateTime.isBefore(now)) {
      initialDateTime = now;
    }

    DateTime? selectedDate;

    var screenHeight = MediaQuery.of(context).size.height;
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: screenHeight * 0.35,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: CupertinoDatePicker(
                  onDateTimeChanged: (DateTime newDateTime) {
                    selectedDate = newDateTime;
                  },
                  initialDateTime: initialDateTime,
                  maximumDate: DateTime(2035),
                  minimumDate: now,
                  mode: CupertinoDatePickerMode.date,
                ),
              ),
              CupertinoButton(
                child: const Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontFamily: "UberMove"),
                ),
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

    var screenHeight = MediaQuery.of(context).size.height;
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: screenHeight * 0.35,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: CupertinoTimerPicker(
                  initialTimerDuration: initialTimerDuration,
                  mode: CupertinoTimerPickerMode.hm,
                  onTimerDurationChanged: (Duration newDuration) {
                    selectedDuration = newDuration;
                  },
                ),
              ),
              CupertinoButton(
                child: const Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontFamily: "UberMove"),
                ),
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: width * 0.90,
              child: _buildDateTimePicker(
                context,
                'Pick up day',
                _pickUpDate,
                'Pick up hour',
                _pickUpTime,
                true,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: width * 0.90,
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
      ],
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
