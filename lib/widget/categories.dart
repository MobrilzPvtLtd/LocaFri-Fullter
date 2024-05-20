import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key, required this.image, required this.ontap});

  final String image;
  final void Function()? ontap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              image: DecorationImage(image: AssetImage(image)),
              boxShadow: const  [
                BoxShadow(color: Colors.black38,blurRadius: 0.1,blurStyle: BlurStyle.normal)
              ]
            ),
            
          ),
        ],
      ),
    );
  }
}