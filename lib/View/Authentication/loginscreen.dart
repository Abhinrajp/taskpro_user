import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/View/Authentication/Resetpassword/resetpasswordscreen.dart';
import 'package:taskpro_user/View/Authentication/singnupscreen.dart';
import 'package:taskpro_user/View/Home/homebottomnavigationbar.dart';
import 'package:taskpro_user/Widget/Simplewidgets.dart';
import 'package:taskpro_user/Widget/showwidget.dart';
import 'package:taskpro_user/Widget/validation/validationforsign.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final mailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
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
            body: SingleChildScrollView(
                child: Form(
                    key: formkey,
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Text('taskpro',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25))),
                          const SizedBox(height: 10),
                          Text('Welcome Back!',
                              style: GoogleFonts.getFont('Lato',
                                  fontSize: 20, color: Colors.white70)),
                          Text('Log in to continue',
                              style: GoogleFonts.getFont('Lato',
                                  fontSize: 10, color: Colors.white60)),
                          const SizedBox(height: 30),
                          Customformfield(
                              keybordtype: TextInputType.emailAddress,
                              validator: validateformail,
                              controller: mailcontroller,
                              hintext: 'email',
                              icon: const Icon(Icons.email_outlined)),
                          const SizedBox(height: 10),
                          Customformfield(
                              keybordtype: TextInputType.name,
                              validator: validateforpassword,
                              controller: passwordcontroller,
                              hintext: 'Password',
                              icon: const Icon(Icons.lock_outline)),
                          const SizedBox(height: 15),
                          const SizedBox(height: 5),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ResetPasswordScreen(),
                                          ));
                                    },
                                    child: Customtext(
                                        text: 'Forget password ?',
                                        color: Colors.blueGrey.shade900,
                                        fontsize: 11,
                                        fontWeight: FontWeight.w400))
                              ]),
                          Customsubmitbutton(
                              widget: const Customtext(
                                  text: 'Login',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              size: const Size(360, 60),
                              ontap: login),
                          const SizedBox(height: 30),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Customtext(
                                    text: 'Do you have an account ?',
                                    color: Colors.blueGrey.shade900,
                                    fontsize: 12,
                                    fontWeight: FontWeight.w400),
                                const SizedBox(width: 5),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Singnupscreen(),
                                          ));
                                    },
                                    child: const Text('Sign up >',
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 4, 9, 11),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)))
                              ])
                        ]))))));
  }

  login() async {
    if (formkey.currentState!.validate()) {
      try {
        log(mailcontroller.text);
        log(passwordcontroller.text);
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: mailcontroller.text, password: passwordcontroller.text);
        mailcontroller.clear();
        passwordcontroller.clear();
        if (!mounted) return;
        showCustomSnackBar(context,
            bgcolor: primarycolour,
            msg: 'Signup success',
            title: 'Signup successfully');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const Homebottomnavigationbar()),
          (route) => false,
        );
      } catch (e) {
        showCustomSnackBar(context,
            bgcolor: primarycolour, msg: 'Error', title: e.toString());
      }
    } else {
      showCustomSnackBar(context,
          msg: "Check all feilds in there",
          title: "Fill all the feilds",
          bgcolor: Colors.red);
    }
  }
}
