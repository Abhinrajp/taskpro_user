import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/View/Authentication/loginscreen.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Profile scree'),
      ),
      floatingActionButton: IconButton(
          onPressed: () async {
            alertboxforconfirmation(context, signout);
          },
          icon: const Icon(Icons.exit_to_app)),
    );
  }

  void alertboxforconfirmation(BuildContext context, Function fun) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: primarycolour,
        title: const Text(
          'Are you sure',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text('Do you want to Logout ?',
            style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                log('logout clicked on the lerbox');
                fun();
              },
              child: const Text('Yes')),
          ElevatedButton(
              onPressed: () {
                log("clicked");
                Navigator.pop(context);
              },
              child: const Text('No')),
        ],
      ),
    );
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Loginscreen()),
        (route) => false);
  }
}
