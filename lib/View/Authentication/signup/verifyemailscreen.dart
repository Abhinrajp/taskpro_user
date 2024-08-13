import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskpro_user/Controller/emailverfyingcontroller.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';

class Verifyemailscreen extends StatefulWidget {
  const Verifyemailscreen({super.key});

  @override
  State<Verifyemailscreen> createState() => _VerifyemailscreenState();
}

class _VerifyemailscreenState extends State<Verifyemailscreen> {
  final Emailverfyingcontroller emailverfyingcontroller =
      Get.put(Emailverfyingcontroller());
  @override
  void initState() {
    emailverfyingcontroller.sendemail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/Asset/emailsendnew-animation.gif'),
          TextButton(
              style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(5),
                  backgroundColor: WidgetStatePropertyAll(primarycolour)),
              onPressed: () {
                emailverfyingcontroller.sendemail();
              },
              child: const Customtext(
                text: 'Resend Link',
                color: Colors.white,
              ))
        ],
      )),
    );
  }
}
