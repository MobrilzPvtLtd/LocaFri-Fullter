import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import '../../Controllers/checkin/checkin_contract_controller.dart';

// ignore: must_be_immutable
class CheckinContractScreen extends StatelessWidget {
  CheckinContractScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final emailController = TextEditingController();
  final kilometerController = TextEditingController();
  Rx<File?> customerSignatureFile = Rx<File?>(null);

  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  final CheckinContractController controller =
      Get.put(CheckinContractController());

  void handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void handleSaveButtonPressed() async {
    final data =
    await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final byteData = await data.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/signature.png';
    final file = File(filePath);

    await file.writeAsBytes(buffer);

    customerSignatureFile.value = file;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            "Check in Contract",
            style: TextStyle(
              fontFamily: "UberMove",
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _fullName(fullNameController),
                _addressAndPostalCode(addressController, postalCodeController),
                _emailAndLicense(controller.licenceImage, emailController),
                _kilometerAndFuelLevel(kilometerController),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Niveau de reservoir',
                        style: TextStyle(
                          fontFamily: "UberMove",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
                _diokilometer(),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Upload Vehicle/Damages",
                    style: TextStyle(
                      fontFamily: "UberMove",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _vehicleDamage(controller.vehicleImages),
                _odometerImage(controller.odometerImage),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Upload Signature",
                        style: TextStyle(
                          fontFamily: "UberMove",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          // borderRadius: BorderRadius.circular(12)
                        ),
                        child: SfSignaturePad(
                          key: signatureGlobalKey,
                          backgroundColor: Colors.white,
                          strokeColor: Colors.black,
                          minimumStrokeWidth: 2.0,
                          maximumStrokeWidth: 4.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: handleSaveButtonPressed,
                            child: const Text(
                              'Capture Signature',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: handleClearButtonPressed,
                            child: const Text(
                              'Clear',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Obx(() {
                        return Checkbox(
                          activeColor: Color(0xffff36a21),
                          value: controller
                              .isChecked.value, // Bind to the reactive boolean
                          checkColor: Colors.white,
                          onChanged: (newValue) {
                            controller.toggleCheckbox(newValue!);
                          },
                        );
                      }),
                      const Text(
                        "I am 18 years of age or older and agree to the terms \n of the Contract and the Valve Privacy Policy",
                        style: TextStyle(fontFamily: "Ubermove"),
                      )
                    ], //
                  ),
                ),
                _submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _diokilometer() {
    return Center(
      child: SizedBox(
        height: 220,
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 9,
              startAngle: 180,
              endAngle: 0,
              showLabels: false,
              showTicks: false,
              radiusFactor: 1.0,
              canScaleToFit: true,
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 0,
                  endValue: 1,
                  color: Colors.lightBlue[100]!,
                  startWidth: 50,
                  endWidth: 50,
                ),
                GaugeRange(
                  startValue: 1,
                  endValue: 2,
                  color: Colors.lightBlue[200]!,
                  startWidth: 50,
                  endWidth: 50,
                ),
                GaugeRange(
                  startValue: 2,
                  endValue: 3,
                  color: Colors.blue[300]!,
                  startWidth: 50,
                  endWidth: 50,
                ),
                GaugeRange(
                  startValue: 3,
                  endValue: 4,
                  color: Colors.blue[400]!,
                  startWidth: 50,
                  endWidth: 50,
                ),
                GaugeRange(
                  startValue: 4,
                  endValue: 5,
                  color: Colors.blue[500]!,
                  startWidth: 50,
                  endWidth: 50,
                ),
                GaugeRange(
                  startValue: 5,
                  endValue: 6,
                  color: Colors.blue[600]!,
                  startWidth: 50,
                  endWidth: 50,
                ),
                GaugeRange(
                  startValue: 6,
                  endValue: 7,
                  color: Colors.blue[700]!,
                  startWidth: 50,
                  endWidth: 50,
                ),
                GaugeRange(
                  startValue: 7,
                  endValue: 8,
                  color: Colors.blue[800]!,
                  startWidth: 50,
                  endWidth: 50,
                ),
                GaugeRange(
                  startValue: 8,
                  endValue: 9,
                  color: Colors.blue[900]!,
                  startWidth: 50,
                  endWidth: 50,
                ),
              ],
              pointers: const <GaugePointer>[
                NeedlePointer(
                  value: 6, // Points to 3/4
                  needleColor: Colors.black,
                  knobStyle:
                      KnobStyle(color: Colors.black, borderColor: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _fullName(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
        left: 15.0,
        top: 5,
      ),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.name,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: "UberMove",
              ),
              hintText: "Full Name",
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
        ],
      ),
    );
  }

  Widget _addressAndPostalCode(TextEditingController addressController, TextEditingController postalCodeController) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Address",
            style: TextStyle(
                fontFamily: "UberMove",
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: addressController,
            keyboardType: TextInputType.streetAddress,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: "UberMove",
              ),
              hintText: "Address",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: postalCodeController,
            keyboardType: TextInputType.number,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: "UberMove",
              ),
              hintText: "Postal Code",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your postal code';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _emailAndLicense(Rx<File?> image, TextEditingController emailController) {
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 5),
          child: TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w800, fontFamily: "UberMove"),
              hintText: "Email",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your E-mail';
              }
              return null;
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Text(
            "Upload ID/Driving License Image",
            style: TextStyle(
              fontFamily: "UberMove",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Obx(() {
          return Stack(
            children: [
              Container(
                width: width * 0.92,
                height: height * 0.20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
                child: image.value == null
                    ? IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _showLicenseImageOptions(Get.context!),
                      )
                    : Image.file(
                        image.value!,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
              ),
              if (image.value != null)
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () =>
                        Get.find<CheckinContractController>().deleteImage(),
                    child: Container(
                      color: Colors.black54,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _kilometerAndFuelLevel(TextEditingController kilometerController) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15.0),
      child: TextFormField(
        controller: kilometerController,
        keyboardType: TextInputType.number,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            fontFamily: "UberMove",
          ),
          hintText: "Kilometers",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your Kilometers';
          }
          return null;
        },
      ),
    );
  }

  Widget _vehicleDamage(RxList<File?> vehicleImages) {
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;
    return Obx(() {
      return Center(
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(4, (index) {
            return Stack(
              children: [
                Container(
                  width: height * 0.20,
                  height: width * 0.40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                  ),
                  child: vehicleImages[index] == null
                      ? IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () =>
                              _showImageVehicaleOptions(Get.context!, index),
                        )
                      : Image.file(
                          vehicleImages[index]!,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                ),
                if (vehicleImages[index] != null)
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () => Get.find<CheckinContractController>()
                          .deleteVehicleImage(index),
                      child: Container(
                        color: Colors.black54,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ),
      );
    });
  }

  Widget _odometerImage(Rx<File?> odometerImage) {
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            "Upload odometer with kms and fuel image",
            style: TextStyle(
              fontFamily: "UberMove",
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() {
          return Stack(
            children: [
              Container(
                width: width * 0.90,
                height: height * 0.20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
                child: odometerImage.value == null
                    ? IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () =>
                            _showImageOdometerOptions(Get.context!),
                      )
                    : Image.file(
                        odometerImage.value!,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
              ),
              if (odometerImage.value != null)
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Get.find<CheckinContractController>()
                        .deleteOdometerImage(),
                    child: Container(
                      color: Colors.black54,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          controller.uploadCheckinContract(
            fullNameController.text, 
              addressController.text, 
              postalCodeController.text, 
              emailController.text, 
              kilometerController.text,
              'full', 
              'no damages in car', 
              customerSignatureFile, 
              context,
              );
          print('Form submitted');
        } else {
          print('Form is not valid');
        }
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
        child: Container(
          height: height * 0.06,
          width: width * 0.90,
          decoration: BoxDecoration(
              color: const Color(0xffff36a21),
              borderRadius: BorderRadius.circular(14)),
          child: const Center(
            child: Text(
              "Submit Form",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showImageVehicaleOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  Get.find<CheckinContractController>()
                      .pickImageFromCamera(index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  Get.find<CheckinContractController>()
                      .pickImageFromGallery(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLicenseImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Get.find<CheckinContractController>().pickImageFromCamera1();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Get.find<CheckinContractController>().pickImageFromGallery1();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showImageOdometerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Get.find<CheckinContractController>()
                      .pickOdometerImageCamera();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Get.find<CheckinContractController>()
                      .pickOdometerImageGallery();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
