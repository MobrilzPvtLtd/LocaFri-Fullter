import 'dart:async';

import 'package:carapp/screen/home/home.dart';
import 'package:flutter/material.dart';

class Splash_screeen extends StatefulWidget {
  const Splash_screeen({super.key});

  @override
  State<Splash_screeen> createState() => _Splash_screeenState();
}

class _Splash_screeenState extends State<Splash_screeen> {
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Image.asset(
          "assets/logo/Final-1.png",
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
