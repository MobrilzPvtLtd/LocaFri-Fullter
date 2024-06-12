import 'package:flutter/material.dart';

class Forget_password extends StatefulWidget {
  const Forget_password({super.key});

  @override
  State<Forget_password> createState() => _Forget_passwordState();
}

class _Forget_passwordState extends State<Forget_password> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "Forget Password",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontFamily: "PostsenOne"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "   Please enter your email or phone number receive\n a password",
                      style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "PostsenOne"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // Password Field

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Email ID",
                            focusColor: Colors.white,
                            disabledBorder: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),

                    // Signup button

                    GestureDetector(
                      onTap: () {
                        // Navigator.
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        height: height * 0.08,
                        width: width * 0.90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffff36a21),

),
                        child: const Center(
                          child: Text(
                            "Reset Password",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "PostsenOne",
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      endIndent: 50,
                      indent: 50,
                    ),
                    const Center(
                      child: Text(
                        "Back to Login",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: "PostsenOne"),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        height: height * 0.08,
                        width: width * 0.90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffff36a21),

),
                        child: const Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "PostsenOne",
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                            "If You have Any Query Click Here Contact US!",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              fontSize: 13,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ]),
            )));
  }
}
