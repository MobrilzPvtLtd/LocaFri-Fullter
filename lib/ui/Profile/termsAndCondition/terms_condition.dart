import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TermAndConditionScreen extends StatefulWidget {
  const TermAndConditionScreen({super.key});

  @override
  State<TermAndConditionScreen> createState() => _TermAndConditionScreenState();
}

class _TermAndConditionScreenState extends State<TermAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Conditions générales",
        ),
        centerTitle: true,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri.uri(
            Uri.parse(
                "https://locafri.ultimatetrueweb.com/terms-and-conditions"),
          ),
        ),
      ),
    );
  }
}
