import 'package:carapp/Controllers/customerDetail/customer_detail_controller.dart';
import 'package:carapp/Controllers/search/searchController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomerDateTimeField extends StatefulWidget {
  const CustomerDateTimeField({super.key});

  @override
  State<CustomerDateTimeField> createState() => _CustomerDateTimeFieldState();
}

class _CustomerDateTimeFieldState extends State<CustomerDateTimeField> {
  final CustomerDetailController controller =
      Get.put(CustomerDetailController());

  final SearchCarsController searchCarsController =
      Get.put(SearchCarsController());

  DateTime? convertStringToDateTime(String dateString) {
  try {
    final format = DateFormat('dd/MM/yyyy');
    return format.parse(dateString);
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

  TimeOfDay? convertStringToTimeOfDay(String timeString) {
  try {
    timeString = timeString.trim().toLowerCase();
    final isAm = timeString.endsWith('am');
    final isPm = timeString.endsWith('pm');
    
    if (!isAm && !isPm) {
      throw const FormatException('Invalid time format. Use HH:mm or hh:mm AM/PM.');
    }

    timeString = timeString.replaceAll('am', '').replaceAll('pm', '').trim();

    final parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = parts.length > 1 ? int.parse(parts[1]) : 0;

    if (isPm && hour < 12) {
      hour += 12; 
    } else if (isAm && hour == 12) {
      hour = 0;
    }

    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      throw RangeError('Hour must be between 0-23 and minutes must be between 0-59.');
    }

    return TimeOfDay(hour: hour, minute: minute);
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

  DateTime _pickUpDate = DateTime.now();
  TimeOfDay _pickUpTime = TimeOfDay.now();
  DateTime _dropOffDate = DateTime.now();
  TimeOfDay _dropOffTime = TimeOfDay.now();
  String? selectedValue;

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
          color: const Color.fromARGB(255, 255, 255, 255),
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
          color: const Color.fromARGB(255, 255, 255, 255),
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
    final width = MediaQuery.of(context).size.width;
    _pickUpDate = convertStringToDateTime(searchCarsController.pickUpDate.value) ?? DateTime.now();
    _pickUpTime = convertStringToTimeOfDay(searchCarsController.pickUpTime.value) ?? TimeOfDay.now(); 
    _dropOffDate = convertStringToDateTime(searchCarsController.dropOffDate.value) ?? DateTime.now(); 
    _dropOffTime = convertStringToTimeOfDay(searchCarsController.dropOffTime.value) ?? TimeOfDay.now();  

    controller.pickUpDate.value = _pickUpDate.toString(); 
    controller.pickUpTime.value = _pickUpTime.toString(); 
    controller.dropOfDate.value = _dropOffDate.toString(); 
    controller.dropOfTime.value = _dropOffTime.toString();   

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
