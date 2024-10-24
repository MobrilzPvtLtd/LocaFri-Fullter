import 'dart:io';
import 'dart:ui' as ui;
import 'package:carapp/Controllers/checkout/checkout_controller.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class CheckoutContractScreen extends StatefulWidget {
  const CheckoutContractScreen({super.key});

  @override
  State<CheckoutContractScreen> createState() => _checkoutContractScreenState();
}

class _checkoutContractScreenState extends State<CheckoutContractScreen> {

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final emailController = TextEditingController();
  final kilometerController = TextEditingController();

  Rx<File?> customerSignatureFile = Rx<File?>(null);

  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  final CheckOutContractController controller =
      Get.put(CheckOutContractController());

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

  File? _image;
  bool value = false;
  final ImagePicker picker = ImagePicker();
  File? odometre;
  List<File?> vehicalimage = List<File?>.filled(4, null);

  Future<void> _cameImage(int index) async {
    final picker = ImagePicker();
    final pickedFileCamera = await picker.pickImage(source: ImageSource.camera);
    if (pickedFileCamera != null) {
      setState(() {
        vehicalimage[index] = File(pickedFileCamera.path);
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Checkout Contract",
          style: TextStyle(
              fontFamily: "UberMove",
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _firstandlastname(nameController),
                _addressandPostalcode(addressController, postalCodeController),
                _emailandLicense(controller.licenceImage, emailController),
                _kilometerandFuelLevelandVehicalDamage(
                    _image, kilometerController),
                const Text(
                  "Upload Vehical/Damages ",
                  style: TextStyle(
                      fontFamily: "UberMove",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                _VehicalDamage(controller.vehicleImages),
                _odometerimage(controller.odometerImage),
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
                      Obx((){
                        return Checkbox(
                          activeColor: Color(0xffff36a21),
                          value: controller.isChecked.value,
                          checkColor: Colors.white,
                          onChanged: (newValue) {
                            controller.toggleCheckbox(newValue!);
                          },
                        );
                      }),
                      const Text(
                        "I am 18 years of age or older and agree to the \n terms of the Contract and the  Valve Privacy \n Policy",
                        style: TextStyle(fontFamily: "Ubermove"),
                      )
                    ], 
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      controller.uploadCheckOutContract(
                        name: nameController.text,
                        address: addressController.text,
                        postalCode: postalCodeController.text,
                        email: emailController.text,
                        recordKilometers: kilometerController.text,
                        signatureImage: customerSignatureFile,
                        fuelLevel: "75",
                        comment: "Good",
                        contractId: SharedPrefs.getContractId.toString(),
                        context: context,
                      );
                    } else {
                      print("Something went wrong");
                    }
                  },
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
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _firstandlastname(TextEditingController nameController) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          keyboardType: TextInputType.name,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w800, fontFamily: "UberMove"),
            hintText: "Full Name",
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
      ],
    );
  }

  _addressandPostalcode(TextEditingController addressController,
      TextEditingController postalCodeController) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
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
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w800, fontFamily: "UberMove"),
              hintText: "Address",
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
            height: 20,
          ),
          TextFormField(
            controller: postalCodeController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w800, fontFamily: "UberMove"),
              hintText: "Postal Code",
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
            height: 20,
          ),
        ],
      ),
    );
  }

  _emailandLicense(Rx<File?> image, TextEditingController emailController) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        TextFormField(
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
          height: 20,
        ),
        const Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Upload ID/Driving License Image",
            style: TextStyle(
                fontFamily: "UberMove",
                fontSize: 20,
                fontWeight: FontWeight.bold),
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
                        Get.find<CheckOutContractController>().deleteImage(),
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
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  _kilometerandFuelLevelandVehicalDamage(
      File? image, TextEditingController kilometerController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Number of Kilometers",
          style: TextStyle(
              fontFamily: "UberMove",
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: kilometerController,
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w800, fontFamily: "UberMove"),
            hintText: "Number of Kilometers",
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
          height: 10,
        ),
        const Text(
          'Niveau de reservoir',
          style: TextStyle(
              fontFamily: "UberMove",
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        Center(
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
                      knobStyle: KnobStyle(
                          color: Colors.black, borderColor: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _VehicalDamage(RxList<File?> vehicleImages) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                              _showImageVehicaleOptions(context, index),
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
                      onTap: () => Get.find<CheckOutContractController>()
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

  _odometerimage(Rx<File?> odometerImage) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Upload odometer with kms and fuel image",
          style: TextStyle(
              fontFamily: "UberMove",
              fontSize: 19,
              fontWeight: FontWeight.bold),
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
                        icon: Icon(Icons.add),
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
                    onTap: () => Get.find<CheckOutContractController>()
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
        })
      ],
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
                  Get.find<CheckOutContractController>()
                      .pickOdometerImageCamera();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Get.find<CheckOutContractController>()
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
                  Get.find<CheckOutContractController>().pickImageFromCamera1();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Get.find<CheckOutContractController>()
                      .pickImageFromGallery1();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
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
                  Get.find<CheckOutContractController>()
                      .pickImageFromCamera(index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  Get.find<CheckOutContractController>()
                      .pickImageFromGallery(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
