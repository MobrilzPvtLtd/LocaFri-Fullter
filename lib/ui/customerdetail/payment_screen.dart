import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:carapp/Controllers/checkout/checkout_controller.dart';
import 'package:carapp/Controllers/customerDetail/customer_detail_controller.dart';
import 'package:carapp/models/payment_transaction_data_model.dart';
import 'package:carapp/ui/payment/payment_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  final String paymentUrl;
  final bool fromCheckout;
  final String token;
  final String price;
  final String vehicleName;
  final String email;
  final String bookingId;
  final String paymentType;

  const PaymentScreen(
      {super.key,
      required this.paymentUrl,
      required this.fromCheckout,
      required this.token,
      required this.price,
      required this.vehicleName,
      required this.email,
      required this.bookingId,
      required this.paymentType});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  CheckOutContractController checkOutContractController =
      Get.put(CheckOutContractController());
  final Completer<void> _completer = Completer<void>();
  late Timer _timer;
  bool _paymentStatusReceived = false;
  String paymentId = "";
  String amountPaid = "";

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
        var data = {
          "booking_id": widget.bookingId,
        };

        var response = await http.post(
          Uri.parse(
              "https://locafri.ultimatetrueweb.com/api/transaction-response"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${widget.token}',
          },
          body: jsonEncode(data),
        );

        log(response.body.toString());

        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);
          final data =
              PaymentTransactionDataModel.fromJson(jsonDecode(response.body));
          log(responseData.toString());
          String status = data.data?.paymentPaid ?? "PENDING";
          String remainingAmount = data.data?.remainingAmount ?? "0.00";
          amountPaid = data.data?.amountPaid ?? "";
          log("The status is $status");
          if (widget.fromCheckout) {
            if (status == "complete" && remainingAmount == "0.00") {
              _stopPolling(timer, true);
            }
          } else {
            if (status == "complete" || status == "failed") {
              _stopPolling(timer, true);
            }
          }
        }
      } catch (e) {
        print("Error checking payment status: $e");
      }
    });
  }

  void _stopPolling(Timer timer, bool paymentCompleted) async {
    timer.cancel();
    checkOutContractController.isPaymentDone.value = paymentCompleted;
    _paymentStatusReceived = paymentCompleted;

    if (!_completer.isCompleted) {
      _completer.complete();
    }

    await Get.to(
      PaymentStatusScreen(
        isPaymentSuccess: paymentCompleted,
        transactionId: paymentId,
        amount: amountPaid,
        fromCheckout: widget.fromCheckout,
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
    return WillPopScope(
      onWillPop: () async {
        return _paymentStatusReceived || !_timer.isActive;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Paiement'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: FutureBuilder<void>(
          future: _completer.future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri.uri(
                  Uri.parse(widget.paymentUrl),
                ),
              ),
              onWebViewCreated: (controller) {},
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }
}
