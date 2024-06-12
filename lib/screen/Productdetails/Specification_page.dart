import 'package:flutter/material.dart';

class Specifications_page extends StatelessWidget {
  const Specifications_page({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
              size: 30,
            )),
        title: Text("Specification",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 30,fontFamily: "UberMove"),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.60,
                child: GridView.builder(
                  itemCount: 8,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      height: height * 0.15,
                      width: width * 0.40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white60,
                          border: Border.all(
                            color: Colors.black38,
                            width: 2,
                          )),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Body",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "UberMove",
                                  fontWeight: FontWeight.w800)),
                          Text("Hatchback",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "UberMove",
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    );
                  },
                ),
                //
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Feature",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontFamily: "UberMove",
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20,),
              SizedBox(
                height: height * 0.30,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_sharp,
                          size: 40,
                          weight: 30,
                          color: Color(0xffff36a21),

                        ),
                        Text("Bluetooth",
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: "UberMove",
                                fontWeight: FontWeight.w700)),
                        
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
