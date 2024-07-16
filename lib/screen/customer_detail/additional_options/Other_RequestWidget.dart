import 'dart:developer';

import 'package:flutter/material.dart';

class Other_RequestWidget extends StatefulWidget {
  const Other_RequestWidget({super.key});

  @override
  State<Other_RequestWidget> createState() => _Other_RequestWidgetState();
}

class _Other_RequestWidgetState extends State<Other_RequestWidget> {
  bool _switchcase = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: width * 0.80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Other Requests",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Switch(
                  inactiveThumbColor: Colors.black,
                  activeColor: Color(0xffff36a21),
                  value: _switchcase,
                  onChanged: (value) {
                    setState(() {
                      _switchcase = value;

                      log(_switchcase.toString());
                    });
                  }),
            ],
          ),
        ),
        _switchcase ? TextFieldWidgets() : Container()
      ],
    );
  }

  Widget TextFieldWidgets() {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextFormField(
            maxLines: 5,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                hintText: "Add Other Requests ",
                focusColor: Colors.white,
                disabledBorder: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ))));
  }
}
