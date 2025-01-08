import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:carapp/Controllers/checkout/checkout_controller.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../Controllers/customerDetail/customer_detail_controller.dart';
import '../../models/create_contract_data.dart';
import '../../widget/bottomnavigation.dart';
import '../customerdetail/payment_screen.dart';

class CheckoutContractScreen extends StatefulWidget {
  final String paymentStatus;
  final String? vehicleName;
  final String? price;
  final int? id;
  final int? contractId;
  final double pendingAmount;
  final String name;
  final String email;
  final String address;
  final String zipCode;
  const CheckoutContractScreen({
    super.key,
    required this.paymentStatus,
    required this.vehicleName,
    required this.price,
    required this.id,
    required this.contractId,
    required this.pendingAmount,
    required this.name,
    required this.email,
    required this.address,
    required this.zipCode,
  });

  @override
  State<CheckoutContractScreen> createState() => _checkoutContractScreenState();
}

class _checkoutContractScreenState extends State<CheckoutContractScreen> {
  final CustomerDetailController _customerController =
      Get.put(CustomerDetailController());
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final emailController = TextEditingController();
  final kilometerController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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
    nameController.text = widget.name;
    emailController.text = widget.email;
    addressController.text = widget.address;
    postalCodeController.text = widget.zipCode;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavigator(
                    initialIndex: 2,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
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
        // controller: _scrollController,
        // physics: controller.isGaugeActive.value
        //     ? NeverScrollableScrollPhysics()
        //     : AlwaysScrollableScrollPhysics(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _firstandlastname(nameController),
                    _addressandPostalcode(
                        addressController, postalCodeController),
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
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: handleClearButtonPressed,
                                child: const Text(
                                  'Clear',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (widget.pendingAmount != 0.00) ...{
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade300),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Pay Pending Amount : ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final createContractData = CreateContractData(
                                    price: widget.price,
                                    vehicleName: widget.vehicleName,
                                    customerEmail: SharedPrefs.getUserEmail,
                                    bookingId: widget.id,
                                    paymentType: _customerController
                                        .stripePaymentType
                                        .value = "payment_full");
                                try {
                                  bool isPaymentInitiated =
                                      await _customerController
                                          .stripePaymentCall(
                                              createContractData, context);

                                  if (isPaymentInitiated) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PaymentScreen(
                                          fromCheckout: true,
                                          paymentUrl: _customerController
                                              .paymentRedirectUrl.value,
                                          email: SharedPrefs.getUserEmail,
                                          bookingId: widget.id.toString(),
                                          paymentType: "payment_full",
                                          price: widget.price.toString(),
                                          vehicleName:
                                              widget.vehicleName.toString(),
                                          token: SharedPrefs.getToken,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Get.snackbar(
                                        "Failed", "Something went wrong");
                                  }
                                } catch (e) {
                                  Get.snackbar("Error",
                                      "An unexpected error occurred: $e");
                                }
                              },
                              child: const Text("Pay Now ->"),
                            )
                          ],
                        ),
                      ),
                    },
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Obx(() {
                            return Checkbox(
                              activeColor: const Color(0xffff36a21),
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
                    Obx(
                      () => GestureDetector(
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
                              contractId: widget.contractId.toString(),
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
                          child: Center(
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            // Obx(
            //   () {
            //     if (controller.isLoading.value) {
            //       return Positioned.fill(
            //         child: Container(
            //           color: Colors.black
            //               .withOpacity(0.5), // Semi-transparent background
            //           child: const Center(
            //             child: CircularProgressIndicator(
            //               color: Colors.black, // Loader color
            //             ),
            //           ),
            //         ),
            //       );
            //     } else {
            //       return const SizedBox
            //           .shrink(); // Empty container if loader is not active
            //     }
            //   },
            // ),
          ],
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
            keyboardType: TextInputType.streetAddress,
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
                return 'Please enter your address';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: postalCodeController,
            keyboardType: TextInputType.phone,
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
                return 'Please enter your Postal Code';
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
              return 'Please enter your Email';
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
          keyboardType: TextInputType.number,
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
          child: GestureDetector(
            onPanStart: (_) {
              controller.isGaugeActive.value = true;
            },
            onPanUpdate: (details) {
              _updateNeedlePosition(details.localPosition, context);
            },
            onTapDown: (details) {
              controller.isGaugeActive.value = true;
              _updateNeedlePosition(details.localPosition, context);
            },
            onPanEnd: (_) {
              controller.isGaugeActive.value = false;
            },
            child: SizedBox(
              height: 220,
              child: Obx(
                () => SfRadialGauge(
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
                        for (int i = 0; i < 9; i++)
                          GaugeRange(
                            startValue: i.toDouble(),
                            endValue: (i + 1).toDouble(),
                            color: Colors.orange[(i + 1) * 100]!,
                            startWidth: 50,
                            endWidth: 50,
                          ),
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(
                          value: controller.needleValue.value,
                          needleColor: Colors.black,
                          knobStyle: const KnobStyle(
                            color: Colors.black,
                            borderColor: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _updateNeedlePosition(Offset localPosition, BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset center = box.size.center(Offset.zero);

    final Offset position = localPosition - center;

    double angle = atan2(position.dy, position.dx);

    double degrees = angle * 180 / pi;
    if (degrees < 0) {
      degrees += 360;
    }

    if (degrees >= 180 && degrees <= 360) {
      double value = 9 * (degrees - 180) / 180;
      controller.updateNeedleValue(value);
    }
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
