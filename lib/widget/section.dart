import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget(
      {super.key,
      required this.leadingText,
      required this.buttonText,
      required this.fontFamily,
      required this.fontSize,
      this.fontWeight,
      this.onpressed});
  final String leadingText;
  final String buttonText;
  final String fontFamily;
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
          style: TextStyle(
              fontSize: fontSize,
              color: Colors.black,
              fontFamily: fontFamily,
              fontWeight: fontWeight),
        ),
        TextButton(
          onPressed: onpressed,
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 20,
                color: const Color(0xffff36a21),
                fontFamily: fontFamily),
          ),
        ),
      ],
    );
  }
}
