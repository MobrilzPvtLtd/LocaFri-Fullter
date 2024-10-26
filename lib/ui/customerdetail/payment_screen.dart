import 'package:carapp/Controllers/customerDetail/customer_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentUrl;
  const PaymentScreen({super.key, required this.paymentUrl});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  InAppWebViewController? _webViewController;
  final CustomerDetailController customerDetailController =
      Get.put(CustomerDetailController());
      
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Payment Gateway"),
          centerTitle: true,
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri.uri(Uri.parse(widget.paymentUrl)),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
          onLoadStop: (InAppWebViewController controller, Uri? url) {
            if (url != null && url.toString().contains("session_id")) { 
              Navigator.of(context).pop(); 
              customerDetailController.fetchStripePaymentDetails(url.toString());
            }
          }
        ),
      ),
    );
  }
}
