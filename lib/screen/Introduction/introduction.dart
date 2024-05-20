import 'package:carapp/screen/auth/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
            Image.asset("assets/images/introduction_image.png",
            ),
            Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(" Looking for a vehicle?\n You're at the right place.",
          style: TextStyle(fontFamily: "Post One",
            color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
           const SizedBox(height: 20,),
            const Text(" Rent a Car Online Today & Enjoy The Best \n Deals Rates And Accessories",
          style: TextStyle(fontFamily: "Post One",
            color: Colors.white60,fontSize: 20,fontWeight: FontWeight.bold),),
            const SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>Sign_in()));
              },
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white
                ),
                child: const  Center(child: Text("Let's Go!",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
                  fontFamily: "Post One",color: Colors.black),)),
              ),
            ),
            
        ],
      ),
        ],
      )
    );
  }
}