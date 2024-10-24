// import 'package:carapp/ui/checkin/checkin_contract_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../Controllers/signIn_controller.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final SigninGetxController _signinGetxController = Get.find();
//   final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           leading: Text(""),
//         ),
//         body: SafeArea(
//           top: true,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const Center(
//                 child: Text(
//                   "Verify your Email",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 40,
//                       color: Colors.black,
//                       fontFamily: "PostsenOne"),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   textAlign: TextAlign.center,
//                   "We have send you an One Time Password(OTP) on the your Email ID",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontFamily: "PostsenOne"),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Form(
//                 key: _formKey1,
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: TextFormField(
//                     keyboardType: TextInputType.number,
//                     maxLength: 6,
//                     onChanged: (value) =>
//                         _signinGetxController.otp.value = value,
//                     decoration: InputDecoration(
//                         hintText: "Enter OTP",
//                         focusColor: Colors.black,
//                         disabledBorder: InputBorder.none,
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         )),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter OTP';
//                       }
//                       if (value.length != 6 ||
//                           !RegExp(r'^\d{6}$').hasMatch(value)) {
//                         return 'OTP must be 6 digits';
//                       }
//                       return null; 
//                     },
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () async {
//                   if (_formKey1.currentState!.validate()) {
//                     bool isVerified = await _signinGetxController.verifyOtp();
//                     if (isVerified) {
//                       Get.to(CheckinContractScreen());
//                     } else {
//                       Get.snackbar("Error",
//                           "OTP verification failed. Please try again.");
//                     }
//                   }
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.all(20),
//                   height: height * 0.06,
//                   width: width * 0.90,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: const Color(0xffff36a21),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       "Confirm",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: "PostsenOne",
//                           fontWeight: FontWeight.w900,
//                           fontSize: 20),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
