import 'package:flutter/material.dart';

class additional_options extends StatefulWidget {
  additional_options(
      {super.key, required this.switchvalue, required this.text});

  @override
  State<additional_options> createState() => _additional_optionsState();
  bool switchvalue;
  String text;
}

class _additional_optionsState extends State<additional_options> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Switch(
            inactiveThumbColor: Colors.black,
            activeColor: Color(0xffff36a21),
            value: widget.switchvalue,
            onChanged: (value) {
              setState(() {
                widget.switchvalue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
