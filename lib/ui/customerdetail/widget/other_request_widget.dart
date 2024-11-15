import 'dart:developer';

import 'package:flutter/material.dart';

class OtherRequestWidget extends StatefulWidget {
  const OtherRequestWidget({super.key});

  @override
  State<OtherRequestWidget> createState() => _OtherRequestWidgetState();
}

class _OtherRequestWidgetState extends State<OtherRequestWidget> {
  bool _switchcase = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
                activeColor: const Color(0xffff36a21),
                value: _switchcase,
                onChanged: (value) {
                  setState(
                    () {
                      _switchcase = value;
                      log(_switchcase.toString());
                    },
                  );
                },
              ),
            ],
          ),
        ),
        _switchcase ? textFieldWidgets() : Container()
      ],
    );
  }

  Widget textFieldWidgets() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        maxLines: 5,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
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
          ),
        ),
      ),
    );
  }
}
