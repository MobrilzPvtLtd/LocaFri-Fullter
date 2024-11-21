import 'package:carapp/Controllers/customerDetail/customer_detail_controller.dart';
import 'package:carapp/Controllers/search/search_controller.dart';
import 'package:carapp/ui/mobility/search_cars.dart';
import 'package:carapp/ui/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchCarsController availableCarsController =
      Get.put(SearchCarsController());
  final CustomerDetailController customerDetailController =
      Get.put(CustomerDetailController());

  String pickUpLoaction = "";
  String pickUpDate = "";
  String pickUpHour = "";

  DateTime _pickUpDate = DateTime.now();
  TimeOfDay _pickUpTime = TimeOfDay.now();
  DateTime _dropOffDate = DateTime.now();
  TimeOfDay _dropOffTime = TimeOfDay.now();

  Future<void> _materialDatePicker(BuildContext context, bool isPickUp) async {
    DateTime now = DateTime.now();
    DateTime initialDate = isPickUp ? _pickUpDate : _dropOffDate;

    if (initialDate.isBefore(now)) {
      initialDate = now;
    }

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: DateTime(2035),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        if (isPickUp) {
          _pickUpDate = selectedDate;
          _pickUpTime = TimeOfDay.fromDateTime(selectedDate);
        } else {
          _dropOffDate = selectedDate;
          _dropOffTime = TimeOfDay.fromDateTime(selectedDate);
        }
      });
    }
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
      minutes: initialDateTime.minute + 5,
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
                  minuteInterval: 5,
                  initialTimerDuration: const Duration(minutes: 0),
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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          width: screenWidth,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: screenHeight,
                width: screenWidth * 0.35,
                padding: const EdgeInsets.all(28.0),
                child: Image.asset(
                  fit: BoxFit.cover,
                  'assets/logo/Final-1.png',
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Profile()));
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              elevation: 3,
              child: Container(
                height: screenHeight * 0.47,
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
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        fontFamily: "UberMove",
                      ),
                    ),
                    Obx(() {
                      if (availableCarsController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: SizedBox(
                          child: DropdownButton<String>(
                            icon: const Icon(
                              Icons.arrow_outward,
                              color: Colors.amber,
                            ),
                            value: availableCarsController
                                    .pickUpLocationValue.value.isEmpty
                                ? null
                                : availableCarsController
                                    .pickUpLocationValue.value,
                            onChanged: (String? newValue) {
                              availableCarsController
                                  .pickUpLocationValue.value = newValue!;
                              pickUpLoaction = newValue;
                            },
                            items: availableCarsController.locations
                                .map<DropdownMenuItem<String>>((location) {
                              return DropdownMenuItem<String>(
                                value: location,
                                child: Text(
                                  location,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.045,
                                    fontFamily: "UberMove",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
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
                      );
                    }),
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
                    Obx(() {
                      if (availableCarsController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: SizedBox(
                          child: DropdownButton<String>(
                            icon: const Icon(
                              Icons.arrow_outward,
                              color: Colors.amber,
                            ),
                            value: availableCarsController
                                    .dropOffLocationValue.value.isEmpty
                                ? null
                                : availableCarsController
                                    .dropOffLocationValue.value,
                            onChanged: (String? newValue) {
                              availableCarsController
                                  .dropOffLocationValue.value = newValue!;
                            },
                            items: availableCarsController.locations
                                .map<DropdownMenuItem<String>>((location) {
                              return DropdownMenuItem<String>(
                                value: location,
                                child: Text(
                                  location,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.045,
                                    fontFamily: "UberMove",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
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
                      );
                    }),
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
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () {
                customerDetailController.pickUpDate.value = _pickUpDate;
                customerDetailController.dropOffDate.value = _dropOffDate;
                customerDetailController.pickUpTime.value = _pickUpTime;
                customerDetailController.dropOffTime.value = _dropOffTime;
                availableCarsController.pickUpDateAndTime.value = _pickUpDate;
                availableCarsController.dropOfDateAndTime.value = _dropOffDate;
                availableCarsController.fetchAvailableCars(pickUpLoaction,
                    _pickUpDate.toString(), _dropOffDate.toString());
                if (!availableCarsController.isLoading.value &&
                    availableCarsController.availableCars.isNotEmpty) {
                  Get.to(() => SearchCars());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffff36a21),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.3,
                  vertical: screenHeight * 0.02,
                ),
                textStyle: const TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Search',
              ),
            ),
          ],
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
                onTap: () => _materialDatePicker(context, isPickUp),
                // onTap: () => _cupertinoDateTimePicker(context, isPickUp),
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
                onTap: () => _materialDatePicker(context, isPickUp),
                // onTap: () => _cupertinoTimePicker(context, isPickUp),
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
