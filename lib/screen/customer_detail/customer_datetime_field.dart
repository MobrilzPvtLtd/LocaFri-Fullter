import 'package:flutter/material.dart';

class Customer_DateTime_Field extends StatefulWidget {
  const Customer_DateTime_Field({super.key});

  @override
  State<Customer_DateTime_Field> createState() => _Customer_DateTime_FieldState();
}

class _Customer_DateTime_FieldState extends State<Customer_DateTime_Field> {
    DateTime picktdatetime = DateTime.now();
  DateTime returnedateTime = DateTime.now();
  TimeOfDay picktime = TimeOfDay.now();
  TimeOfDay returntime = TimeOfDay.now();

  Future<void> _pickDateTime(BuildContext context) async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: picktdatetime,
      firstDate: DateTime.now(),
      onDatePickerModeChange: (value) {
        DatePickerEntryMode.calendar;
      },
      lastDate: DateTime(2099),
    );
    if (picker != null && picker != picktdatetime) {
      setState(() {
        picktdatetime = picker;
      });
    }
  }
   Future<void> _returnDateTime(BuildContext context) async {
    DateTime? returnpicker = await showDatePicker(
      context: context,
      initialDate: returnedateTime,
      firstDate: DateTime.now(),
      onDatePickerModeChange: (value) {
        DatePickerEntryMode.calendar;
      },
      lastDate: DateTime(2099),
    );
    if (returnpicker != null && returnpicker != returnedateTime) {
      setState(() {
        returnedateTime = returnpicker;
      });
    }
  }

  void _picktime() {
    showTimePicker(context: context, initialTime: picktime,
    )
        .then((value) => setState(() {
              picktime = value!;
            }));
  }
  void _returntime() {
    showTimePicker(context: context, initialTime: returntime,
    )
        .then((value) => setState(() {
              returntime = value!;
            }));
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         const  Text("Pick Up Date & Time",style:  TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove",fontWeight: FontWeight.w700),),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              elevation: 0,
              shape:const  RoundedRectangleBorder(side: BorderSide(width: 20,color: Colors.transparent,style: BorderStyle.none))
            ),
              onPressed: () {
                _pickDateTime(context);
              },
              child: const Text("Select the date",style:  TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove",fontWeight: FontWeight.w600,),)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              elevation: 0,
              shape:const  RoundedRectangleBorder(side: BorderSide(width: 20,color: Colors.transparent,style: BorderStyle.none))
            ),
              onPressed: () {
                _picktime();
              },
              child: const Text("Select the Time",style:  TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove",fontWeight: FontWeight.w600,),)),
          
            ],
            
          ),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Date: ${picktdatetime.toLocal().day}-"
              "${picktdatetime.toLocal().month}-"
              "${picktdatetime.toLocal().year}",style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove",fontWeight: FontWeight.w500,),),
              Text("Time: ${picktime.hour}:""${picktime.minute}",style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove",fontWeight: FontWeight.w500,),)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Return Date & Time",style:  TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove",fontWeight: FontWeight.w900,),),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              elevation: 0,
              shape:const  RoundedRectangleBorder(side: BorderSide(width: 20,color: Colors.transparent,style: BorderStyle.none))
            ),
              onPressed: () {
                _returnDateTime(context);
              },
              child: const Text("Select the date",style:  TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove",fontWeight: FontWeight.w600,),)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              elevation: 0,
              shape:const  RoundedRectangleBorder(side: BorderSide(width: 20,color: Colors.transparent,style: BorderStyle.none))
            ),
              onPressed: () {
                _returntime();
              },
              child: const Text("Select the Time",style:  TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove",fontWeight: FontWeight.w600,),)),
          
            ],
            
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Date: ${returnedateTime.toLocal().day}-"
              "${returnedateTime.toLocal().month}-"
              "${returnedateTime.toLocal().year}",style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove"),),
              Text("Time: ${returntime.hour}:""${returntime.minute}",style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove"),)
            ],
          )
      ],
    );
  }
}