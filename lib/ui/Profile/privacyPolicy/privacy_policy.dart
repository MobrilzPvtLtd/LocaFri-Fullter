import 'package:carapp/Controllers/profile/privacy_policy_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  final PrivacyPolicyController controller = Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    controller.fetchPrivacyPolicyData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy & Policy"),
        centerTitle: true,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri.uri(
            Uri.parse(
                "https://locafri.ultimatetrueweb.com/privacy"),
          ),
        ),
      ),
    );
  }
}

Widget customTextWidget(
  String text, {
  double? fontSize,
  double? wordSpacing,
  double? letterSpacing,
  double? textHeight,
  int? maxLines,
  TextAlign? textAlign,
  TextOverflow? overflow,
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Text(
    text,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: TextStyle(
      height: textHeight,
      wordSpacing: wordSpacing,
      letterSpacing: letterSpacing,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}
