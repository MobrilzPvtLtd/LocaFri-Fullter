import 'package:carapp/Controllers/profile/contact_us_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final commentController = TextEditingController();
  final ContactUsController controller = ContactUsController();

  bool? checkbox = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          leading: const Text(""),
          backgroundColor: Colors.white10,
          bottom: AppBar(
            title: const Text(
              "Contact us",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                fontFamily: "UberMove",
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: nameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: emailController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Email ID",
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
                      return "Please enter an email";
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: commentController,
                  maxLines: 8,
                  maxLength: 500,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Message",
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
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: checkbox,
                    onChanged: (newBool) {
                      setState(() {
                        checkbox = newBool;
                      });
                    },
                    tristate: false,
                    activeColor: const Color(0xffff36a21),
                  ),
                  const Text(
                    "I have read and accept the privacy policy.",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "UberMove",
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      controller.sendRequest(nameController.text,
                          emailController.text, commentController.text);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    height: height * 0.08,
                    width: width * 0.90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xffff36a21),
                    ),
                    child: controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : const Center(
                            child: Text(
                              "Send",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "UberMove",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
