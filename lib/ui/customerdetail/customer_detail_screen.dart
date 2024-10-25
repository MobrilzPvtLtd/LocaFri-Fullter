import 'package:carapp/Controllers/search/searchController.dart';
import 'package:carapp/ui/customerdetail/widget/other_request_widget.dart';
import 'package:carapp/ui/customerdetail/widget/additional_option_widget.dart';
import 'package:carapp/ui/customerdetail/widget/select_days_widget.dart';
import 'package:carapp/ui/customerdetail/widget/customer_datetime_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/customerDetail/customer_detail_controller.dart';

class CustomerDetailScreen extends StatefulWidget {
  final String vehicleName;
  final String dPrice;
  final String wPrice;
  final String mPrice;

  const CustomerDetailScreen(
      {super.key,
      required this.vehicleName,
      required this.dPrice,
      required this.wPrice,
      required this.mPrice});
  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  final SearchCarsController availableCarsController =
      Get.put(SearchCarsController());

  final CustomerDetailController controller =
      Get.put(CustomerDetailController()); 

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var screenWidth = MediaQuery.of(context).size.width;
    controller.selectedPickUpLocation.value =
        availableCarsController.pickUpLocationValue.value; 
    controller.selectedDropOffLocation.value = availableCarsController.dropOffLocationValue.value; 

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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
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
                    suffix: GestureDetector(
                      child: const Text("verify"),
                      onTap: () {
                        controller.verifyEmail(controller.email.value, context);
                      },
                    ),
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
                    ? additionalOptionWidget(controller: controller)
                    : Container()),
                const SizedBox(height: 20),
                const SelectDaysWidget(),
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
                    value: availableCarsController
                            .pickUpLocationValue.value.isEmpty
                        ? null
                        : availableCarsController.pickUpLocationValue.value,
                    onChanged: (String? newValue) {
                      controller.selectedPickUpLocation.value = newValue!;
                    },
                    items: availableCarsController.locations
                        .map<DropdownMenuItem<String>>((location) {
                      return DropdownMenuItem<String>(
                        value: location,
                        child: Text(
                          location,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045,
                            fontFamily: "UberMove",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
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
                    value: availableCarsController.dropOffLocationValue.value.isEmpty
                        ? null
                        : availableCarsController.dropOffLocationValue.value,
                    onChanged: (String? newValue) {
                      controller.selectedDropOffLocation.value = newValue!;
                    },
                    items: availableCarsController.locations
                        .map<DropdownMenuItem<String>>((location) {
                      return DropdownMenuItem<String>(
                        value: location,
                        child: Text(
                          location,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045,
                            fontFamily: "UberMove",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
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
                const CustomerDateTimeField(),
                const SizedBox(height: 20),
                Container(
                  height: height * 0.08,
                  width: width * 0.50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: Colors.black26),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                        controller.submitForm(
                          context,
                          widget.vehicleName,
                          widget.dPrice,
                          widget.wPrice,
                          widget.mPrice, 
                          
                        );
                    }
                  },
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

  Widget additionalOptionWidget(
      {required CustomerDetailController controller}) {
    return Column(
      children: [
        Obx(() => AdditionalOptionsWidget(
            switchvalue: controller.isAdditionalDriver.value,
            text: "Additional Driver",
            onChanged: controller.toggleAdditionalDriver)),
        Obx(() => AdditionalOptionsWidget(
            switchvalue: controller.isChildBoosterSeat.value,
            text: "Child Booster Seat",
            onChanged: controller.toggleChildBoosterSeat)),
        Obx(() => AdditionalOptionsWidget(
            switchvalue: controller.isChildSeat.value,
            text: "Child Seat",
            onChanged: controller.toggleChildSeat)),
        Obx(() => AdditionalOptionsWidget(
            switchvalue: controller.isExitPermit.value,
            text: "Exit Permit",
            onChanged: controller.toggleExitPermit)),
        const OtherRequestWidget(),
      ],
    );
  }
}
