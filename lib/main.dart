import 'package:carapp/screen/Introduction/introduction.dart';
import 'package:carapp/screen/Productdetails/productdetail.dart';
import 'package:carapp/screen/auth/Forget/forgetpassword.dart';
import 'package:carapp/screen/auth/sign_in/sign_in.dart';
import 'package:carapp/screen/auth/sign_up/sign_up.dart';
import 'package:carapp/screen/home/home.dart';
import 'package:carapp/webview.dart';
import 'package:carapp/widget/categories.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
      home: Product_detail(),
    );
  }
}
