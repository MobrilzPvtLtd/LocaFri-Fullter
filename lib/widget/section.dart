import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget(
      {super.key, required this.leadingText, required this.ButtonText});
  final String leadingText;
  final String ButtonText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leadingText,
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontFamily: "Postsenone"),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              ButtonText,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.amber[600],
                  fontFamily: "PostsenOne"),
            ))
      ],
    );
  }
}
