import 'package:carapp/Controllers/profile/profile_controller.dart';
import 'package:carapp/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    firstNameController.text = SharedPrefs.getUserFisrtName;
    lastNameController.text = SharedPrefs.getUserLastName;
    phoneNumberController.text = SharedPrefs.getUserPhoneNumber;
    emailController.text = SharedPrefs.getUserEmail;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage("assets/images/person.jpg"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: firstNameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                      return "Please enter an first name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: lastNameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                      return "Please enter an last name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneNumberController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                      return "Please enter an Phone number";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.updateProfile(
                          firstNameController.text,
                          lastNameController.text,
                          emailController.text,
                          phoneNumberController.text,
                          context,
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrangeAccent,
                      ),
                      child: controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          : const Center(
                              child: Text(
                                "Update Profile",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
