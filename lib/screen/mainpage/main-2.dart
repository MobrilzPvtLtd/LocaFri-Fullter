import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _pickUpDate = DateTime.now();
  TimeOfDay _pickUpTime = TimeOfDay.now();
  DateTime _dropOffDate = DateTime.now();
  TimeOfDay _dropOffTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context, bool isPickUp) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isPickUp ? _pickUpDate : _dropOffDate,
      firstDate: DateTime.now(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/logo/Final-1.png', // Ensure you have this asset in your project
          height: 50,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'SmartKey - connected car',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Unlock the car using your mobile, with no need to go to the desk',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('+ More information'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Pick up office',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildDateTimePicker(context, 'Pick up day', _pickUpDate, 'Pick up hour', _pickUpTime, true),
              SizedBox(height: 10),
              _buildDateTimePicker(context, 'Drop off day', _dropOffDate, 'Drop off hour', _dropOffTime, false),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (bool? value) {}),
                  Text('Return to a different office'),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Driver's age",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: '25-74 Years',
                items: <String>['18-24 Years', '25-74 Years', '75+ Years'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
                isExpanded: true,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Search'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'Mobility'),
          BottomNavigationBarItem(icon: Icon(Icons.room_service), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.wifi), label: 'SmartKey'),
        ],
      ),
    );
  }

  Widget _buildDateTimePicker(BuildContext context, String dateLabel, DateTime dateValue, String timeLabel, TimeOfDay timeValue, bool isPickUp) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(dateLabel, style: TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(width: 10),
            Expanded(child: Text(timeLabel, style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectDate(context, isPickUp),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(DateFormat('dd/MM/yyyy').format(dateValue), textAlign: TextAlign.center),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context, isPickUp),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(timeValue.format(context), textAlign: TextAlign.center),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
