import 'package:flutter/material.dart';

class buttonprofile extends StatelessWidget {
  const buttonprofile(
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
         
        children: [
          Container(
            height: height * 0.08,
            width: width * 0.15,
            // color: Colors.amber,
            child: Icon(
              Icons,
              color: Colors.black,
              size: 35,
            ),
          ),
          Container(
            height: height * 0.08,
            width: width * 0.60,
            // color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: Colors.black,
                      fontFamily: "UberMove"),
                ),
              ],
            ),
          ),
          Container(
            height: height * 0.08,
            width: width * 0.15,
            // color: Colors.amber,
            child: Icon(
              Icons2,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
