import 'dart:ffi';
import 'dart:io';

import 'package:carapp/widget/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class checkin_contract extends StatefulWidget {
  const checkin_contract({super.key});

  @override
  State<checkin_contract> createState() => _checkin_contractState();
}

class _checkin_contractState extends State<checkin_contract> {
  File? _image;
  bool value = false;
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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        // odometre = File(pickedFile.path);
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Check in Contract",
          style: TextStyle(
              fontFamily: "UberMove",
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _firstandlastname(),
            _addressandPostalcode(),
            _emailandLicense(_image),
            _kilometerandFuelLevelandVehicalDamage(_image),
            const Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Upload Vehical/Damages ",
                style: TextStyle(
                    fontFamily: "UberMove",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            _VehicalDamage(vehicalimage),
            _odometerimage(odometre),
            Row(
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
                  "I am 18 years of age or older and agree to the terms \n of the Contract and the Valve Privacy Policy",
                  style: TextStyle(fontFamily: "Ubermove"),
                )
              ], //I am 13 years of age or older and agree to the terms of the Steam Subscriber Agreement and the Valve Privacy Policy
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => BottomNavigator()));
              },
              child: Container(
                height: height * 0.07,
                width: width * 0.90,
                decoration: BoxDecoration(
                  color: Color(0xffff36a21),

                  borderRadius: BorderRadius.circular(20),
                  // border: Border.all(color: Colors.black, width: 2)
                ),
                child: const Center(
                    child: Text(
                  "SUBMIT FORM",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: "UberMove",
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  _firstandlastname() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            keyboardType: TextInputType.name,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                hintText: "First Name",
                focusColor: Colors.white,
                disabledBorder: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            keyboardType: TextInputType.name,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                hintText: "Last Name",
                focusColor: Colors.white,
                disabledBorder: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
      ],
    );
  }

  _addressandPostalcode() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Address",
              style: TextStyle(
                  fontFamily: "UberMove",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
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
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
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
          ),
        ],
      ),
    );
  }

  _emailandLicense(
    File? image,
  ) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
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
              color: Colors.grey[300],
              child: image == null
                  ? IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _pickImage(),
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

  _kilometerandFuelLevelandVehicalDamage(File? image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Number of Kilometers",
            style: TextStyle(
                fontFamily: "UberMove",
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
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
                )),
          ),
        ),
        const Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Fuel Level",
            style: TextStyle(
                fontFamily: "UberMove",
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.w800, fontFamily: "UberMove"),
                hintText: "Fuel Level",
                focusColor: Colors.white,
                disabledBorder: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.all(15.0),
        //   child: TextFormField(
        //     keyboardType: TextInputType.emailAddress,
        //     cursorColor: Colors.black,
        //     decoration: InputDecoration(
        //         focusedBorder: OutlineInputBorder(
        //           borderSide: BorderSide(color: Colors.black),
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         hintStyle: const TextStyle(
        //             fontWeight: FontWeight.w800, fontFamily: "UberMove"),
        //         hintText: "Vehicle Damage",
        //         focusColor: Colors.white,
        //         disabledBorder: InputBorder.none,
        //         filled: true,
        //         fillColor: Colors.white,
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(10),
        //         )),
        //   ),
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
      ],
    );
  }

  _VehicalDamage(List<File?> image) {
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
                color: Colors.grey[300],
                child: image[index] == null
                    ? IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => _vehicalimage(index),
                      )
                    : Image.file(
                        image[index]!,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
              ),
              if (image[index] != null)
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
          height: 40,
        ),
        const Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Upload odometer with kms and fuel image",
            style: TextStyle(
                fontFamily: "UberMove",
                fontSize: 19,
                fontWeight: FontWeight.bold),
          ),
        ),
        Stack(
          children: [
            Container(
              width: width * 0.90,
              height: height * 0.20,
              color: Colors.grey[300],
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
