import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskpro_user/Services/authservices.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';
import 'package:taskpro_user/Widget/validation/validationforsign.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  Authservices authservices = Authservices();
  final email = TextEditingController();
  final password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        primarycolour,
        Colors.white,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white)),
          backgroundColor: Colors.transparent,
          title: const Text(
            'Reset Password',
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    SizedBox(
                        height: 170,
                        child: LottieBuilder.asset(
                          'lib/Asset/resetanimation2.json',
                        )),
                    const SizedBox(height: 50),
                    Customformfield(
                      controller: email,
                      validator: validateformail,
                      hintext: 'Email',
                      keybordtype: TextInputType.emailAddress,
                      icon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            await resetpassword();
                            email.clear();
                          } else {
                            resetpassword();
                          }
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(primarycolour),
                            fixedSize: WidgetStatePropertyAll(Size(350, 60))),
                        child: const Text(
                          'Reset',
                          style: TextStyle(color: Colors.white),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  resetpassword() {
    authservices.resetpass(email.text);
  }
}
