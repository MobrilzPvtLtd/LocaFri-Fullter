import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdditionalOptionsWidget extends StatefulWidget {
  AdditionalOptionsWidget(
      {super.key, required this.switchvalue, required this.text, required onChanged});

  @override
  State<AdditionalOptionsWidget> createState() => _AdditionalOptionsWidgetState();
  bool switchvalue;
  String text;
}

class _AdditionalOptionsWidgetState extends State<AdditionalOptionsWidget> {

  @override
  Widget build(BuildContext context) {
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
            activeColor: const Color(0xffff36a21),
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
