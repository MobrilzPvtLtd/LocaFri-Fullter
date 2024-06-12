import 'dart:ffi';

import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget(
      {super.key, required this.leadingText, required this.ButtonText, required this.FontFamily, required this.fontSize, this.fontWeight, this.onpressed});
  final String leadingText;
  final String ButtonText;
  final String FontFamily;
  final double fontSize;
  final FontWeight? fontWeight;
  final void Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leadingText,
          style:  TextStyle(
              fontSize: fontSize, color: Colors.black, fontFamily: FontFamily,fontWeight: fontWeight),
        ),
        TextButton(
            onPressed: onpressed,
            child: Text(
              ButtonText,
              style: TextStyle(
                
                  fontSize: 20,
                  color: Color(0xffff36a21),
                  fontFamily: FontFamily ),
            ))
      ],
    );
  }
}
