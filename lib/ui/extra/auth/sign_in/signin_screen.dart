// import 'package:carapp/ui/auth/Otp/otp_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../Controllers/signIn_controller.dart';

// class SigninScreen extends StatefulWidget {
//   const SigninScreen({super.key});

//   @override
//   State<SigninScreen> createState() => _SigninScreenState();
// }

// class _SigninScreenState extends State<SigninScreen> {
//   SigninGetxController signinGetxController = Get.put(SigninGetxController());

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//       ),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         minimum: const EdgeInsets.symmetric(horizontal: 10),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Image.asset("assets/logo/final-3.png"),
//               ),
//               const Text(
//                 "Looking for a vehicle? You're at the right place",
//                 style: TextStyle(
//                     fontSize: 35,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "UberMove"),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),

//               Form(
//                 key: _formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: TextFormField(
//                     onChanged: (value) =>
//                         signinGetxController.email.value = value,
//                     cursorColor: Colors.black,
//                     decoration: InputDecoration(
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       hintText: "Email ID",
//                       hintStyle: const TextStyle(
//                           fontWeight: FontWeight.w800, fontFamily: "UberMove"),
//                       focusColor: Colors.white,
//                       disabledBorder: InputBorder.none,
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your E-mail';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ),

//               GestureDetector(
//                 onTap: () async {
//                   bool success = await signinGetxController.requestotp();
//                   if (success) {
//                     Get.to(const OtpScreen());
//                   } else {
//                     Get.snackbar(
//                         "Error", "Failed to request OTP. Please try again.");
//                   }
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.all(15),
//                   height: height * 0.06,
//                   width: width * 0.90,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color:const Color(0xffff36a21),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       "Verify Email",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: "UberMove",
//                           fontSize: 20,
//                           fontWeight: FontWeight.w900),
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
