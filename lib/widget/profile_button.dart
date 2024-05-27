import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profile_Button extends StatelessWidget {
  const Profile_Button(
      {super.key,
      this.onPressed,
      required this.Icons,
      required this.Icons2,
      required this.text});
  final void Function()? onPressed;
  final IconData Icons;
  final IconData Icons2;
  final String text;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height * 0.10,
        width: width,
        color: Colors.white70,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons,
              color: Colors.black,
              size: 30,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  color: Colors.black,
                  fontFamily: "UberMove"),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons2,
              color: Colors.black,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
