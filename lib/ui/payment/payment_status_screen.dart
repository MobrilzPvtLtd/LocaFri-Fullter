import 'package:carapp/widget/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentStatusScreen extends StatefulWidget {
  final bool isPaymentSuccess;
  final String transactionId;
  final String amount;
  final bool fromCheckout;
  const PaymentStatusScreen({
    super.key,
    required this.isPaymentSuccess,
    required this.transactionId,
    required this.amount,
    required this.fromCheckout,
  });

  @override
  State<PaymentStatusScreen> createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends State<PaymentStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Payment Status"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offAll(const BottomNavigator());
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.isPaymentSuccess
                  ? const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 50.0,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 70,
                      ),
                    )
                  : const CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 50.0,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 70,
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              widget.isPaymentSuccess
                  ? const Text(
                      "Payment successful",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      "Payment failed",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
              Container(
                margin: const EdgeInsets.only(top: 15, right: 10, left: 10),
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 10, right: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text(
                    //   "Transaction Id : ",
                    //   style: TextStyle(fontSize: 16, color: Colors.black),
                    // ),
                    // Text(
                    //   "${widget.transactionId} ",
                    //   style: const TextStyle(fontSize: 15, color: Colors.black),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Row(
                      children: [
                        const Text(
                          "Amount : ",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          "${widget.amount} ",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, right: 10, left: 10),
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 10, right: 10),
                child: const Text(
                    "Thank you, Please take a screenshot or save the details for your reference..."),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (widget.fromCheckout) {
                    Navigator.pop(context);
                  } else {
                    Get.offAll(const BottomNavigator());
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    "Close",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
