import 'package:carapp/screen/auth/auth_controller/signin_controller.dart';
import 'package:carapp/screen/contract/checkin_contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/signIn_controller.dart';
import '../../../widget/bottomnavigationbar.dart';

class Otp_screen extends StatefulWidget {
  const Otp_screen({super.key});

  @override
  State<Otp_screen> createState() => _Otp_screenState();
}

class _Otp_screenState extends State<Otp_screen> {
  final SigninGetxController _signinGetxController = Get.find();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: Text(""),
               ),
              body: SafeArea(
              top: true,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Center(
                      child: Text(
                        "Verify your Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.black,
                            fontFamily: "PostsenOne"),
                        ),
                      ),
                       SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:  Text(
                        textAlign: TextAlign.center,
                        "We have send you an One Time Password(OTP) on the your Email ID",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "PostsenOne"),
                             ),
                    ),
                           SizedBox(
                        height: 20,
                           ),

                    // Password Field

                    Form(
                      key: _formKey1,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 6,
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
                          validator: (value) {
                            // Validate if the input is a 6-digit number
                            if (value == null || value.isEmpty) {
                              return 'Please enter OTP';
                            }
                            if (value.length != 6 || !RegExp(r'^\d{6}$').hasMatch(value)) {
                              return 'OTP must be 6 digits';
                            }
                            return null; // If valid, return null
                          },


                        ),
                      ),
                    ),

                    // Signup button

                    GestureDetector(
                      // onTap: () {
                      //   _signinGetxController.verifyOtp();
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (_) => checkin_contract()));
                      // },

                      // onTap: () {
                      //   // Validate the form before proceeding
                      //   if (_formKey1.currentState!.validate()) {
                      //     _signinGetxController.verifyOtp();
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (_) => checkin_contract()),
                      //     );
                      //   }
                      // },
                      onTap: () async {
                        // Validate the form before proceeding
                        if (_formKey1.currentState!.validate()) {
                          // Call verifyOtp and await its completion
                          bool isVerified = await _signinGetxController.verifyOtp();

                          // Check if the OTP verification was successful
                          if (isVerified) {
                            // Navigate to the checkin_contract screen if verification is successful
                            Get.to(checkin_contract());
                          } else {
                            Get.snackbar("Error", "OTP verification failed. Please try again.");
                          }
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        height: height * 0.06,
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
                                fontWeight: FontWeight.w900,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ]))),
    );
  }
}
