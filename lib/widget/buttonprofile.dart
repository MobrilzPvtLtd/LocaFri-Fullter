import 'package:flutter/material.dart';

class Buttonprofile extends StatelessWidget {
  const Buttonprofile({
    super.key,
    this.onPressed,
    required this.icon,
    required this.icon2,
    required this.text,
  });
  final void Function()? onPressed;
  final IconData icon;
  final IconData icon2;
  final String text;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: height * 0.08,
            width: width * 0.15,
            child: Icon(
              icon,
              color: Colors.black,
              size: 35,
            ),
          ),
          SizedBox(
            height: height * 0.08,
            width: width * 0.58,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: "UberMove"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.08,
            width: width * 0.15,
            child: Icon(
              icon2,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
