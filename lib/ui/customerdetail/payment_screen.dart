import 'dart:async';

import 'package:carapp/Controllers/customerDetail/customer_detail_controller.dart';
import 'package:carapp/ui/payment/payment_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../widget/bottomnavigation.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentUrl;
  final bool fromCheckout;

  const PaymentScreen(
      {super.key, required this.paymentUrl, required this.fromCheckout});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Completer<void> _completer = Completer<void>();
  late Timer _timer;
  bool _paymentStatusReceived = false;
  String paymentId = "";

  @override
  void initState() {
    super.initState();
    _startPaymentPolling();
  }

  void _startPaymentPolling() async {
    const Duration pollingInterval = Duration(seconds: 5);
    const Duration maxDuration = Duration(minutes: 3);

    DateTime startTime = DateTime.now();

    _timer = Timer.periodic(pollingInterval, (timer) async {
      if (DateTime.now().difference(startTime) > maxDuration) {
        _stopPolling(timer, false);
        return;
      }

      try {
        // API Call
      } catch (e) {
        print("Error checking payment status: $e");
      }
    });
  }

  void _stopPolling(Timer timer, bool paymentCompleted) async {
    timer.cancel();
    _paymentStatusReceived = paymentCompleted;

    if (!_completer.isCompleted) {
      _completer.complete();
    }

    await Get.to(
      PaymentStatusScreen(
        isPaymentSuccess: paymentCompleted,
        transactionId: paymentId,
        amount: "10 ",
      ),
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }

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
              // Fetch payment details
              customerDetailController
                  .fetchStripePaymentDetails(url.toString());

              // Navigate based on the flag
              if (widget.fromCheckout) {
                // Pop back to the previous screen
                Navigator.pop(context);
              } else {
                // Navigate to BottomNavigator if from create contract
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => BottomNavigator()),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
