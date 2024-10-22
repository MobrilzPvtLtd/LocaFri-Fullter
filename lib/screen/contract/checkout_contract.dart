import 'dart:io';
import 'dart:ui' as ui;
import 'package:carapp/Controllers/checkout_controller.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class checkout_contract extends StatefulWidget {
  const checkout_contract({super.key});

  @override
  State<checkout_contract> createState() => _checkout_contractState();
}

class _checkout_contractState extends State<checkout_contract> {
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

    // Get the application directory
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/signature.png';
    final file = File(filePath);

    // Write the bytes to the file
    await file.writeAsBytes(buffer);

    // Update the Rx variable
    customerSignatureFile.value = file;
  }

  File? _image;
  bool value = false;
  File? licenseimage;
  final ImagePicker picker = ImagePicker();
  File? odometre;
  List<File?> vehicalimage = List<File?>.filled(4, null);

  Future<void> _vehicalimage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        vehicalimage[index] = File(pickedFile.path);
      });
    }
  }

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
  // correct the code
  // Future<void> _cameImage(int index) async {
  //   try {
  //     final picker = ImagePicker();
  //     final pickedFileCamera =
  //         await picker.pickImage(source: ImageSource.camera);
  //
  //     if (pickedFileCamera != null) {
  //       final directory = await getApplicationDocumentsDirectory();
  //       final path = '${directory.path}/${pickedFileCamera.name}';
  //       final File newImage = await File(pickedFileCamera.path).copy(path);
  //       setState(() {
  //         if (index >= vehicalimage.length) {
  //           vehicalimage.add(null); // Extend the list if necessary
  //         }
  //         vehicalimage[index] = newImage;
  //       });
  //
  //       print('Image saved at: ${newImage.path}');
  //     } else {
  //       print('No image selected.');
  //     }
  //   } catch (e) {
  //     print('Error picking image: $e');
  //   }
  // }

  // _cameImage(int index) async {
  //   if (images.length == index) {
  //     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //     images.add(image!);
  //     // notifyListeners();
  //   }
  // }
  Future<void> _odometreImagePicker() async {
    final picker = ImagePicker();
    final odometreImagePicker =
        await picker.pickImage(source: ImageSource.camera);

    if (odometreImagePicker != null) {
      setState(() {
        // _image = File(pickedFile.path);
        odometre = File(odometreImagePicker.path);
      });
    }
  }

  Future<void> _licenseImagePicker() async {
    final picker = ImagePicker();
    final licenseImagePicker =
        await picker.pickImage(source: ImageSource.camera);
    if (licenseImagePicker != null) {
      setState(() {
        // _image = File(pickedFile.path);
        licenseimage = File(licenseImagePicker.path);
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      vehicalimage[index] = null;
    });
  }

  void _deleteOdometerImage() {
    setState(() {
      odometre = null;
    });
  }

  void _deletelicenseImage() {
    setState(() {
      _image = null;
    });
  }

  void _showImageSourceOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  // await _cameImage();
                  await _cameImage(index);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await _vehicalimage(index);
                },
              ),
            ],
          ),
        );
      },
    );
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
          child: Column(
            children: [
              _firstandlastname(nameController),
              _addressandPostalcode(addressController, postalCodeController),
              _emailandLicense(licenseimage, emailController),
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
              _VehicalDamage(vehicalimage),
              _odometerimage(odometre),
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
                    Checkbox(
                      activeColor: Color(0xffff36a21),
                      value: value,
                      checkColor: Colors.white,
                      onChanged: (newvalue) {
                        setState(() {
                          value = newvalue!;
                        });
                      },
                    ),
                    const Text(
                      "I am 18 years of age or older and agree to the \n terms of the Contract and the  Valve Privacy \n Policy",
                      style: TextStyle(fontFamily: "Ubermove"),
                    )
                  ], //I am 13 years of age or older and agree to the terms of the Steam Subscriber Agreement and the Valve Privacy Policy
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
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
                borderSide: BorderSide(color: Colors.black),
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
              )),
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
                  borderSide: BorderSide(color: Colors.black),
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
                )),
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
                  borderSide: BorderSide(color: Colors.black),
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
                )),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _emailandLicense(File? images1, TextEditingController emailController) {
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
                borderSide: BorderSide(color: Colors.black),
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
              )),
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
        Stack(
          children: [
            Container(
              width: width * 0.90,
              height: height * 0.20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300],
              ),
              child: images1 == null
                  ? IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _licenseImagePicker();
                      },
                      // onPressed: () => _pickImage(),
                    )
                  : Image.file(
                      images1,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
            ),
            if (images1 != null)
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () => _deletelicenseImage(),
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
        ),
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
        Text(
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
              borderSide: BorderSide(color: Colors.black),
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
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Niveau de reservoir',
          style: TextStyle(
              fontFamily: "UberMove",
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 15, right: 15.0),
        //   child: Align(
        //       alignment: Alignment.bottomLeft,
        //       child: Text(
        //         'Niveau de reservoir',
        //         style: TextStyle(
        //           fontFamily: "UberMove",
        //           fontSize: 20,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       )),
        // ),
        Center(
          child: SizedBox(
            // width: 300,
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

                  // annotations: <GaugeAnnotation>[
                  //   GaugeAnnotation(
                  //
                  //     widget: Container(
                  //
                  //       child: Text('3/4',
                  //           style: TextStyle(
                  //               fontSize: 20, fontWeight: FontWeight.bold)),
                  //     ),
                  //     angle: 90,
                  //     positionFactor: 0.6,
                  //   ),
                  // ],

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

  _VehicalDamage(List<File?> images) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                child: images[index] == null
                    ? IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () =>
                            _showImageSourceOptions(context, index),
                      )
                    : Image.file(
                        images[index]!,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
              ),
              if (images[index] != null)
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _deleteImage(index),
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
  }

  _odometerimage(File? image) {
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
        Stack(
          children: [
            Container(
              width: width * 0.90,
              height: height * 0.20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300],
              ),
              child: image == null
                  ? IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _odometreImagePicker(),
                    )
                  : Image.file(
                      image,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
            ),
            if (image != null)
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () => _deleteOdometerImage(),
                  child: Container(
                    color: Colors.black54,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        )
        // ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //         shape: const RoundedRectangleBorder(
        //             side: BorderSide(width: 2, color: Colors.black)),
        //         backgroundColor: Colors.amber,
        //         elevation: 0),
        //     onPressed: () {
        //       _odometreImagePicker();
        //       // setState(() {});
        //     },
        //     child: const Text(
        //       "odometer with kms and fuel image",
        //       style: TextStyle(
        //           fontFamily: "Ubermove",
        //           fontWeight: FontWeight.bold,
        //           color: Colors.black),
        //     )),
      ],
    );
  }
}
