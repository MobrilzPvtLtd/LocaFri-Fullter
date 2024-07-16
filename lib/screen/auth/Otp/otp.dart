import 'package:carapp/screen/auth/auth_controller/signin_controller.dart';
import 'package:carapp/screen/contract/checkin_contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/bottomnavigationbar.dart';

class Otp_screen extends StatefulWidget {
  const Otp_screen({super.key});

  @override
  State<Otp_screen> createState() => _Otp_screenState();
}

class _Otp_screenState extends State<Otp_screen> {
  final SigninGetxController _signinGetxController = Get.find();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Text(""),
        ),
        body: SafeArea(
            top: true,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Verify your Email",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.black,
                          fontFamily: "PostsenOne"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    "We have send you an One Time Password(OTP) on the your Email ID",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "PostsenOne"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Password Field

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      onChanged: (value) =>
                          _signinGetxController.otp.value = value,
                      decoration: InputDecoration(
                          hintText: "Enter OTP",
                          focusColor: Colors.black,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),

                  // Signup button

                  GestureDetector(
                    onTap: () {
                      // _signinGetxController.verfiyotp();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => checkin_contract()));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      height: height * 0.08,
                      width: width * 0.90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffff36a21),
                      ),
                      child: const Center(
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "PostsenOne",
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ])));
  }
}
