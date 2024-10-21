// import 'package:carapp/screen/auth/sign_in/sign_in.dart';
// import 'package:carapp/screen/customer_detail/additional_options/Other_RequestWidget.dart';
// import 'package:carapp/screen/customer_detail/additional_options/additional_options.dart';
// import 'package:carapp/screen/customer_detail/additional_options/selectdays.dart';
// import 'package:carapp/screen/customer_detail/customer_datetime_field.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// class Customer_Detail_one extends StatefulWidget {
//   Customer_Detail_one({super.key});
//
//   @override
//   State<Customer_Detail_one> createState() => _Customer_Detail_oneState();
// }
//
// class _Customer_Detail_oneState extends State<Customer_Detail_one> {
//   String? selectedValue;
//   String? _selectedValue;
//   List<DropdownMenuItem<String>> get dropdownItems {
//     List<DropdownMenuItem<String>> menuItems = [
//       DropdownMenuItem(child: Text("Romont Gare"), value: "Romont Gare"),
//     ];
//     return menuItems;
//   }
//
//   bool _AdditionalOption = false;
//   bool AdditionalDriver = false;
//   bool ChildBoosterSeat = false;
//   bool ChildSeat = false;
//   bool ExitPermit = false;
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold( backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//               size: 30,
//             )),
//         title: const Text(
//           "Detail Form",
//           style: TextStyle(
//               fontSize: 30,
//               color: Colors.black,
//               fontFamily: "UberMove",
//               fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: TextFormField(
//                 keyboardType: TextInputType.name,
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     hintStyle: const TextStyle(
//                         fontWeight: FontWeight.w800,
//                         fontFamily: "UberMove"),
//                     hintText: "Full Name ",
//                     focusColor: Colors.white,
//                     disabledBorder: InputBorder.none,
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     )),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: TextFormField(
//                 keyboardType: TextInputType.number,
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     hintStyle: const TextStyle(
//                         fontWeight: FontWeight.w800,
//                         fontFamily: "UberMove"),
//                     hintText: "Phone Number",
//                     focusColor: Colors.white,
//                     disabledBorder: InputBorder.none,
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     )),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: TextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     hintStyle: const TextStyle(
//                         fontWeight: FontWeight.w800,
//                         fontFamily: "UberMove"),
//                     hintText: "Email",
//                     focusColor: Colors.white,
//                     disabledBorder: InputBorder.none,
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     )),
//               ),
//             ),
//             SizedBox(
//               width: width * 0.90,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Select Additional Option",
//                     style: TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   Switch(
//                     inactiveThumbColor: Colors.black,
//                     activeColor: Color(0xffff36a21),
//                     value: _AdditionalOption,
//                     onChanged: (value) {
//                       setState(() {
//                         _AdditionalOption = value;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             _AdditionalOption ? AdditionalOptionWidget() : Container(),
//
//             const SizedBox(
//               height: 20,
//             ),
//
//             /// this additional option to select the day and week and month
//             /// this widget do select day and month week and how day,week and month  buy rental car
//             const Selectdayoption(),
//
//             const SizedBox(
//               height: 20,
//             ),
//
//             // this Pick and Drop location section
//
//             /***
//            *
//            *
//            * this section help you to select Pick and Drop location
//            *
//            *
//            *
//            */
//             const Text(
//               "Pick Up Location",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontFamily: "UberMove",
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(
//               height: 55,
//               width: width * 0.90,
//               child: DropdownButton<String>(
//                 // elevation: 0,
//                 isDense: false,
//                 icon: const Icon(
//                   Icons.arrow_outward,
//                   color: Colors.amber,
//                 ),
//                 value: selectedValue,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedValue = newValue;
//                   });
//                 },
//                 items: dropdownItems,
//                 hint: const Text("Select Your Pickup Location",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontFamily: "UberMove")),
//                 isExpanded: true,
//                 style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontFamily: "UberMove"),
//               ),
//             ),
//             const Text(
//               "Drop Off Location",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontFamily: "UberMove",
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(
//               height: 55,
//               width: width * 0.90,
//               child: DropdownButton<String>(
//                 icon: const Icon(
//                   Icons.arrow_outward,
//                   color: Colors.amber,
//                 ),
//                 // elevation: 0,
//                 isDense: false,
//
//                 value: _selectedValue,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedValue = newValue;
//                   });
//                 },
//                 items: dropdownItems,
//                 hint: const Text("Select Your Drop Off Location",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontFamily: "UberMove")),
//                 isExpanded: true,
//                 style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontFamily: "UberMove"),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//
//             // Time And Date Picker Widget this widget
//             //allow to customer selected car pick time and
//             // car return time
//
//             /***
//            *
//            *
//            * this section help you to select Pick Day and Time and Drop Day Time
//            *
//            *
//            *
//            */
//
//             const Customer_DateTime_Field(),
//             const SizedBox(
//               height: 20,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (_) => const Sign_in()));
//               },
//               child: Container(
//                 height: height * 0.06,
//                 width: width * 0.90,
//                 decoration: BoxDecoration(
//                   color: const Color(0xffff36a21),
//
//                   borderRadius: BorderRadius.circular(20),
//                   // border: Border.all(color: Colors.black, width: 2)
//                 ),
//                 child: const Center(
//                     child: Text(
//                   "Submit Form",
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontFamily: "UberMove",
//                       fontWeight: FontWeight.w800,
//                       color: Colors.white),
//                 )),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget AdditionalOptionWidget() {
//     return Column(
//       children: [
//         additional_options(
//             switchvalue: AdditionalDriver, text: "Additional Driver"),
//         additional_options(
//             switchvalue: ChildBoosterSeat, text: "Child Booster Seat"),
//         additional_options(switchvalue: ChildSeat, text: "Child Seat"),
//         additional_options(switchvalue: ExitPermit, text: "Exit Permit"),
//         Other_RequestWidget(),
//       ],
//     );
//   }
// }

import 'dart:developer';

import 'package:carapp/screen/customer_detail/additional_options/Other_RequestWidget.dart';
import 'package:carapp/screen/customer_detail/additional_options/additional_options.dart';
import 'package:carapp/screen/customer_detail/additional_options/selectdays.dart';
import 'package:carapp/screen/customer_detail/customer_datetime_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/customerDetail_controller.dart';

class Customer_Detail_one extends StatefulWidget {
  Customer_Detail_one({super.key});
  @override
  State<Customer_Detail_one> createState() => _Customer_Detail_oneState();
}

class _Customer_Detail_oneState extends State<Customer_Detail_one> {
  final CustomerDetailController controller =
      Get.put(CustomerDetailController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Detail Form",
          style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontFamily: "UberMove",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  onChanged: controller.updateFirstName,
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "First Name ",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: controller.updateLastName,
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "Last Name ",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  onChanged: controller.updatePhoneNumber,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "Phone Number",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // Update phone number
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value){
                    controller.updateEmail(value, context);
                  },
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  validator: controller.validateEmail,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                    hintText: "Email",
                    focusColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    suffix: GestureDetector(child: const Text("verify"), onTap: (){
                      controller.verifyEmail(controller.email.value, context);
                    },),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // Update email
                ),
                const SizedBox(
                  height: 15,
                ),

                Obx(
                  () => SwitchListTile(
                    title: const Text(
                      "Select Additional Option",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    value: controller.isAdditionalOptionEnabled.value,
                    onChanged: controller.toggleAdditionalOption,
                    activeColor: const Color(0xffff36a21),
                  ),
                ),
                Obx(() => controller.isAdditionalOptionEnabled.value
                    ? AdditionalOptionWidget(controller: controller)
                    : Container()),
                const SizedBox(height: 20),
                const Selectdayoption(),
                const SizedBox(height: 20),
                const Text(
                  "Pick Up Location",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "UberMove",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: width * 0.90,
                  child: DropdownButton<String>(
                    isDense: false,
                    icon: const Icon(
                      Icons.arrow_outward,
                      color: Colors.amber,
                    ),
                    value: controller.selectedPickUpLocation.value.isEmpty
                        ? null
                        : controller.selectedPickUpLocation.value,
                    onChanged: (String? newValue) {
                      controller.selectedPickUpLocation.value = newValue!;
                    },
                    items: const [
                      DropdownMenuItem(
                          child: Text("Romont Gare"), value: "Romont Gare"),
                    ],
                    hint: const Text(
                      "Select Your Pickup Location",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "UberMove"),
                    ),
                    isExpanded: true,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "UberMove"),
                  ),
                ),
                const Text(
                  "Drop Off Location",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "UberMove",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 55,
                  width: width * 0.90,
                  child: DropdownButton<String>(
                    icon: const Icon(
                      Icons.arrow_outward,
                      color: Colors.amber,
                    ),
                    isDense: false,
                    value: controller.selectedDropOffLocation.value.isEmpty
                        ? null
                        : controller.selectedDropOffLocation.value,
                    onChanged: (String? newValue) {
                      controller.selectedDropOffLocation.value = newValue!;
                    },
                    items: const [
                      DropdownMenuItem(
                          child: Text("Romont Gare"), value: "Romont Gare"),
                    ],
                    hint: const Text(
                      "Select Your Drop Off Location",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "UberMove"),
                    ),
                    isExpanded: true,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "UberMove"),
                  ),
                ),
                const SizedBox(height: 20),
                // Time and Date Picker Widget
                const Customer_DateTime_Field(),
                const SizedBox(height: 20),
                Container(
                  height: height * 0.08,
                  width: width * 0.50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: Colors.black26)),
                  child: const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,

                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Submit button
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Call the submitForm method and pass the context for dialog handling
                      controller.submitForm(context);
                    }
                  },

                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (_) => const Sign_in(),
                  //     ),
                  //   );
                  // },
                  // onTap: controller.submitForm, // Submit form using controller

                  child: Container(
                    height: height * 0.06,
                    width: width * 0.90,
                    decoration: BoxDecoration(
                      color: const Color(0xffff36a21),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Submit Form",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "UberMove",
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget AdditionalOptionWidget(
      {required CustomerDetailController controller}) {
    return Column(
      children: [
        Obx(() => additional_options(
            switchvalue: controller.isAdditionalDriver.value,
            text: "Additional Driver",
            onChanged: controller.toggleAdditionalDriver)),
        Obx(() => additional_options(
            switchvalue: controller.isChildBoosterSeat.value,
            text: "Child Booster Seat",
            onChanged: controller.toggleChildBoosterSeat)),
        Obx(() => additional_options(
            switchvalue: controller.isChildSeat.value,
            text: "Child Seat",
            onChanged: controller.toggleChildSeat)),
        Obx(() => additional_options(
            switchvalue: controller.isExitPermit.value,
            text: "Exit Permit",
            onChanged: controller.toggleExitPermit)),
        Other_RequestWidget(),
      ],
    );
  }
}

//
// import 'package:carapp/screen/auth/sign_in/sign_in.dart';
// import 'package:carapp/screen/customer_detail/additional_options/Other_RequestWidget.dart';
// import 'package:carapp/screen/customer_detail/additional_options/additional_options.dart';
// import 'package:carapp/screen/customer_detail/additional_options/selectdays.dart';
// import 'package:carapp/screen/customer_detail/customer_datetime_field.dart';
// // import 'package:carapp/screen/customer_detail/customer_detail_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Controllers/customerDetail_controller.dart';
//
// class Customer_Detail_one extends StatefulWidget {
//   Customer_Detail_one({super.key});
//
//   @override
//   State<Customer_Detail_one> createState() => _Customer_Detail_oneState();
// }
//
// class _Customer_Detail_oneState extends State<Customer_Detail_one> {
//   // Initialize the controller
//   final CustomerDetailController controller = Get.put(CustomerDetailController());
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//               size: 30,
//             )),
//         title: const Text(
//           "Detail Form",
//           style: TextStyle(
//               fontSize: 30,
//               color: Colors.black,
//               fontFamily: "UberMove",
//               fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: TextFormField(
//                 keyboardType: TextInputType.name,
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     hintStyle: const TextStyle(
//                         fontWeight: FontWeight.w800,
//                         fontFamily: "UberMove"),
//                     hintText: "Full Name ",
//                     focusColor: Colors.white,
//                     disabledBorder: InputBorder.none,
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     )),
//                 onChanged: controller.updateFullName,  // Update name in controller
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: TextFormField(
//                 keyboardType: TextInputType.number,
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     hintStyle: const TextStyle(
//                         fontWeight: FontWeight.w800,
//                         fontFamily: "UberMove"),
//                     hintText: "Phone Number",
//                     focusColor: Colors.white,
//                     disabledBorder: InputBorder.none,
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                 ),
//                 onChanged: controller.updatePhoneNumber,  // Update phone number
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: TextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     hintStyle: const TextStyle(
//                         fontWeight: FontWeight.w800,
//                         fontFamily: "UberMove"),
//                     hintText: "Email",
//                     focusColor: Colors.white,
//                     disabledBorder: InputBorder.none,
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     )),
//                 onChanged: controller.updateEmail,  // Update email
//               ),
//             ),
//
//             // Additional Options
//             Obx(() => SwitchListTile(
//               title: const Text(
//                 "Select Additional Option",
//                 style: TextStyle(
//                     fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               value: controller.isAdditionalOptionEnabled.value,
//               onChanged: controller.toggleAdditionalOption,
//               activeColor: const Color(0xffff36a21),
//             )),
//             Obx(() => controller.isAdditionalOptionEnabled.value
//                 ? AdditionalOptionWidget(controller: controller)
//                 : Container()),
//
//             const SizedBox(height: 20),
//
//             // Day selection widget
//             const Selectdayoption(),
//
//             const SizedBox(height: 20),
//
//             // Pick Up and Drop Off Location Section
//             const Text(
//               "Pick Up Location",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontFamily: "UberMove",
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(
//               height: 55,
//               width: width * 0.90,
//               child: DropdownButton<String>(
//                 isDense: false,
//                 icon: const Icon(
//                   Icons.arrow_outward,
//                   color: Colors.amber,
//                 ),
//                 value: controller.selectedPickUpLocation.value.isEmpty
//                     ? null
//                     : controller.selectedPickUpLocation.value,
//                 onChanged: (String? newValue) {
//                   controller.selectedPickUpLocation.value = newValue!;
//                 },
//                 items: const [
//                   DropdownMenuItem(
//                       child: Text("Romont Gare"), value: "Romont Gare"),
//                 ],
//                 hint: const Text("Select Your Pickup Location",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontFamily: "UberMove")),
//                 isExpanded: true,
//                 style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontFamily: "UberMove"),
//               ),
//             ),
//             const Text(
//               "Drop Off Location",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontFamily: "UberMove",
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(
//               height: 55,
//               width: width * 0.90,
//               child: DropdownButton<String>(
//                 icon: const Icon(
//                   Icons.arrow_outward,
//                   color: Colors.amber,
//                 ),
//                 isDense: false,
//                 value: controller.selectedDropOffLocation.value.isEmpty
//                     ? null
//                     : controller.selectedDropOffLocation.value,
//                 onChanged: (String? newValue) {
//                   controller.selectedDropOffLocation.value = newValue!;
//                 },
//                 items: const [
//                   DropdownMenuItem(
//                       child: Text("Romont Gare"), value: "Romont Gare"),
//                 ],
//                 hint: const Text("Select Your Drop Off Location",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontFamily: "UberMove")),
//                 isExpanded: true,
//                 style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontFamily: "UberMove"),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // Time and Date Picker Widget
//             const Customer_DateTime_Field(),
//
//             const SizedBox(height: 20),
//
//             // Submit button
//             GestureDetector(
//               onTap: controller.submitForm,  // Submit form using controller
//               child: Container(
//                 height: height * 0.06,
//                 width: width * 0.90,
//                 decoration: BoxDecoration(
//                   color: const Color(0xffff36a21),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Center(
//                     child: Text(
//                       "Submit Form",
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: "UberMove",
//                           fontWeight: FontWeight.w800,
//                           color: Colors.white),
//                     )),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget AdditionalOptionWidget({required CustomerDetailController controller}) {
//     return Column(
//       children: [
//         Obx(() => additional_options(
//             switchvalue: controller.isAdditionalDriver.value,
//             text: "Additional Driver",
//             onChanged: controller.toggleAdditionalDriver)),
//         Obx(() => additional_options(
//             switchvalue: controller.isChildBoosterSeat.value,
//             text: "Child Booster Seat",
//             onChanged: controller.toggleChildBoosterSeat)),
//         Obx(() => additional_options(
//             switchvalue: controller.isChildSeat.value,
//             text: "Child Seat",
//             onChanged: controller.toggleChildSeat)),
//         Obx(() => additional_options(
//             switchvalue: controller.isExitPermit.value,
//             text: "Exit Permit",
//             onChanged: controller.toggleExitPermit)),
//         Other_RequestWidget(),
//       ],
//     );
//   }
// }
