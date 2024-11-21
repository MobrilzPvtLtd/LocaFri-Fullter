import 'package:carapp/Controllers/customerDetail/customer_detail_controller.dart';
import 'package:carapp/Controllers/search/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomerDateTimeField extends StatelessWidget {
  final String dPrice;
  final String wPrice;
  final String mPrice;
  CustomerDateTimeField(
      {super.key,
      required this.dPrice,
      required this.wPrice,
      required this.mPrice});

  final CustomerDetailController controller =
      Get.put(CustomerDetailController());
  final SearchCarsController searchCarsController =
      Get.put(SearchCarsController());

  Future<void> _materialDatePicker(BuildContext context, bool isPickUp) async {
    DateTime now = DateTime.now();
    DateTime initialDate =
        isPickUp ? controller.pickUpDate.value : controller.dropOffDate.value;

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
      if (isPickUp) {
        controller.pickUpDate.value = selectedDate;
        controller.pickUpTime.value = TimeOfDay.fromDateTime(selectedDate);
      } else {
        controller.dropOffDate.value = selectedDate;
        controller.dropOffTime.value = TimeOfDay.fromDateTime(selectedDate);
      }
      controller.calculateDateDifference(
        controller.pickUpDate.value,
        controller.dropOffDate.value,
        dPrice,
        wPrice,
        mPrice,
      );
    }

    // if (selectedDate != null) {
    //   if (isPickUp) {
    //     controller.pickUpDate.value = selectedDate;
    //   } else {
    //     controller.dropOffDate.value = selectedDate;
    //   }

    //   controller.calculateDateDifference(
    //     controller.pickUpDate.value,
    //     controller.dropOffDate.value,
    //     dPrice,
    //     wPrice,
    //     mPrice,
    //   );
    // }
  }

  Future<void> _cupertinoDateTimePicker(
      BuildContext context, bool isPickUp) async {
    DateTime now = DateTime.now();
    DateTime initialDateTime =
        isPickUp ? controller.pickUpDate.value : controller.dropOffDate.value;

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
                      color: Colors.black, fontWeight: FontWeight.w800),
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
      if (isPickUp) {
        controller.pickUpDate.value = selectedDate!;
        controller.pickUpTime.value = TimeOfDay.fromDateTime(selectedDate!);
      } else {
        controller.dropOffDate.value = selectedDate!;
        controller.dropOffTime.value = TimeOfDay.fromDateTime(selectedDate!);
      }
      controller.calculateDateDifference(controller.pickUpDate.value,
          controller.dropOffDate.value, dPrice, wPrice, mPrice);
    }
  }

  Future<void> _cupertinoTimePicker(BuildContext context, bool isPickUp) async {
    DateTime initialDateTime =
        isPickUp ? controller.pickUpDate.value : controller.dropOffDate.value;

    Duration initialTimerDuration =
        Duration(hours: initialDateTime.hour, minutes: initialDateTime.minute);
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
                      color: Colors.black, fontWeight: FontWeight.w800),
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
      DateTime updatedDateTime =
          isPickUp ? controller.pickUpDate.value : controller.dropOffDate.value;
      updatedDateTime = DateTime(
        updatedDateTime.year,
        updatedDateTime.month,
        updatedDateTime.day,
      ).add(selectedDuration!);

      if (isPickUp) {
        controller.pickUpDate.value = updatedDateTime;
        controller.pickUpTime.value = TimeOfDay.fromDateTime(updatedDateTime);
      } else {
        controller.dropOffDate.value = updatedDateTime;
        controller.dropOffTime.value = TimeOfDay.fromDateTime(updatedDateTime);
      }
      controller.calculateDateDifference(controller.pickUpDate.value,
          controller.dropOffDate.value, dPrice, wPrice, mPrice);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: width * 0.90,
              child: _buildDateTimePicker(context, 'Pick up day', true),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: width * 0.90,
                child: _buildDateTimePicker(context, 'Drop off day', false),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimePicker(
      BuildContext context, String dateLabel, bool isPickUp) {
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
                    fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: Text(
                isPickUp ? 'Pick up hour' : 'Drop off hour',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                // onTap: () => _cupertinoDateTimePicker(context, isPickUp),
                onTap: () => _materialDatePicker(context, isPickUp),

                child: Obx(() {
                  DateTime dateValue = isPickUp
                      ? controller.pickUpDate.value
                      : controller.dropOffDate.value;
                  return Container(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(dateValue),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: GestureDetector(
                onTap: () => _cupertinoTimePicker(context, isPickUp),
                child: Obx(() {
                  TimeOfDay timeValue = isPickUp
                      ? controller.pickUpTime.value
                      : controller.dropOffTime.value;
                  return Container(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      timeValue.format(context),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
