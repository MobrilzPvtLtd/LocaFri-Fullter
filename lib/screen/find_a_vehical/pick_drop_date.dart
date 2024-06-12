import 'package:flutter/material.dart';

class Pick_Drop_Date extends StatefulWidget {
  const Pick_Drop_Date({super.key});

  @override
  State<Pick_Drop_Date> createState() => _Pick_Drop_DateState();
}

class _Pick_Drop_DateState extends State<Pick_Drop_Date> {
     DateTime _picktdatetime = DateTime.now();
  DateTime _returnedateTime = DateTime.now();
  TimeOfDay _picktime = TimeOfDay.now();
  TimeOfDay _returntime = TimeOfDay.now();

  Future<void> _pickDateTime(BuildContext context) async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: _picktdatetime,
      firstDate: DateTime.now(),
      onDatePickerModeChange: (value) {
        DatePickerEntryMode.calendar;
      },
      lastDate: DateTime(2099),
    );
    if (picker != null && picker != _picktdatetime) {
      setState(() {
        _picktdatetime = picker;
      });
    }
  }
   Future<void> _return_Date_Time(BuildContext context) async {
    DateTime? returnpicker = await showDatePicker(
      context: context,
      initialDate: _returnedateTime,
      firstDate: DateTime.now(),
      onDatePickerModeChange: (value) {
        DatePickerEntryMode.calendar;
      },
      lastDate: DateTime(2099),
    );
    if (returnpicker != null && returnpicker != _returnedateTime) {
      setState(() {
        _returnedateTime = returnpicker;
      });
    }
  }

  void _pick_time() {
    showTimePicker(context: context, initialTime: _picktime,
    )
        .then((value) => setState(() {
              _picktime = value!;
            }));
  }
  void _return_time() {
    showTimePicker(context: context, initialTime: _returntime,
    )
        .then((value) => setState(() {
              _returntime = value!;
            }));
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
         const  Text("Pick Up Date & Time",style:  TextStyle(fontSize: 20,color: Colors.black54,fontFamily: "UberMove",fontWeight: FontWeight.w700),),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                 width: width*0.50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    

                    // backgroundColor: Colors.white,
                backgroundColor: Color(0xffff36a21),
                elevation: 0,
                shape:  RoundedRectangleBorder(side: BorderSide(width: 50,color: Colors.transparent,style: BorderStyle.none),)
                             ),
                onPressed: () {
                  _pickDateTime(context);
                },
                child: const Text("Select the date",style:  TextStyle(fontSize: 15,color: Colors.white,fontFamily: "UberMove",fontWeight: FontWeight.w600,),)),
              ),
          SizedBox(
            width: width*0.40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffff36a21),
                elevation: 0,
                shape:  RoundedRectangleBorder(side: BorderSide(width: 50,color: Colors.transparent,style: BorderStyle.none))
              ),
                onPressed: () {
                  _pick_time();
                },
                child: const Text("Select the Time",style:  TextStyle(fontSize: 15,color: Colors.white,fontFamily: "UberMove",fontWeight: FontWeight.w600,),)),
          ),
          
            ],
            
          ),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Date: ${_picktdatetime.toLocal().day}-"
              "${_picktdatetime.toLocal().month}-"
              "${_picktdatetime.toLocal().year}",style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove",fontWeight: FontWeight.w500,),),
              Text("Time: ${_picktime.hour}:""${_picktime.minute}",style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove",fontWeight: FontWeight.w500,),)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Return Date & Time",style:  TextStyle(fontSize: 20,color: Colors.black54,fontFamily: "UberMove",fontWeight: FontWeight.w700,),),
          SizedBox(
            width: width,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: width*0.50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffff36a21),
                  elevation: 0,
                  shape:const  RoundedRectangleBorder(side: BorderSide(width: 50,color: Colors.transparent,style: BorderStyle.none))
                                ),
                  onPressed: () {
                    _return_Date_Time(context);
                  },
                  child: const Text("Select the date",style:  TextStyle(fontSize: 15,color: Colors.white,fontFamily: "UberMove",fontWeight: FontWeight.w600,),)),
                ),
            SizedBox(
              width: width*0.40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffff36a21),
                  elevation: 0,
                  shape:const  RoundedRectangleBorder(side: BorderSide(width: 50,color: Colors.transparent,style: BorderStyle.none))
                ),
                  onPressed: () {
                    _return_time();
                  },
                  child: const Text("Select the Time",style:  TextStyle(fontSize: 15,color: Colors.white,fontFamily: "UberMove",fontWeight: FontWeight.w600,),)),
            ),
            
              ],
              
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Date: ${_returnedateTime.toLocal().day}-"
              "${_returnedateTime.toLocal().month}-"
              "${_returnedateTime.toLocal().year}",style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove"),),
              Text("Time: ${_returntime.hour}:""${_returntime.minute}",style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: "UberMove"),)
            ],
          )
      ],
    );
  }
}