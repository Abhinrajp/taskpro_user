import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/View/Authentication/loginscreen.dart';
import 'package:taskpro_user/View/Home/homebottomnavigationbar.dart';
import 'package:taskpro_user/Widget/Simplewidgets.dart';
import 'package:taskpro_user/Widget/showwidget.dart';
import 'package:taskpro_user/Widget/validation/validationforsign.dart';

class Singnupscreen extends StatefulWidget {
  const Singnupscreen({super.key});

  @override
  State<Singnupscreen> createState() => _SingnupscreenState();
}

class _SingnupscreenState extends State<Singnupscreen> {
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
                        Text('''Let's Get Started!''',
                            style: GoogleFonts.getFont('Lato',
                                fontSize: 20, color: Colors.white70)),
                        Text('''Let's dive into your account''',
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
                        Customsubmitbutton(
                            ontap: sigup,
                            size: const Size(0, 60),
                            widget: Row(children: [
                              SizedBox(
                                  height: 30,
                                  child:
                                      Image.asset('lib/Asset/googleicon.png')),
                              const SizedBox(width: 55),
                              const Customtext(
                                  text: 'Continue with google',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)
                            ])),
                        Customsubmitbutton(
                            ontap: sigup,
                            size: const Size(360, 60),
                            widget: const Customtext(
                                text: 'Sign up',
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        const Customtext(
                            text: 'By signing up, you agree to our'),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {},
                                  child: const Customtext(
                                      text: 'Terms of services, ',
                                      color:
                                          Color.fromARGB(255, 22, 115, 191))),
                              const Customtext(text: 'and '),
                              GestureDetector(
                                  onTap: () {},
                                  child: const Customtext(
                                      text: 'Privacy Policy',
                                      color: Color.fromARGB(255, 22, 115, 191)))
                            ]),
                        const SizedBox(height: 40),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Customtext(
                                  text: 'Already have an account ?'),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Loginscreen()));
                                  },
                                  child: const Customtext(
                                      text: ' Log in',
                                      color: Color.fromARGB(255, 22, 115, 191)))
                            ])
                      ]),
                    )))));
  }

  sigup() async {
    log(mailcontroller.text);
    log(passwordcontroller.text);
    if (formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: mailcontroller.text, password: passwordcontroller.text);
        mailcontroller.clear();
        passwordcontroller.clear();
        if (!mounted) return;
        showCustomSnackBar(context,
            bgcolor: primarycolour,
            msg: 'Account created',
            title: 'Account created successfully');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const Homebottomnavigationbar()),
          (route) => false,
        );
      } catch (e) {
        if (!mounted) return;
        showCustomSnackBar(context,
            bgcolor: primarycolour, msg: 'Error', title: e.toString());
      }
    } else {
      if (!mounted) return;
      showCustomSnackBar(context,
          bgcolor: primarycolour,
          msg: 'Fill all the feild',
          title: 'Check all the feild in here');
    }
  }
}
