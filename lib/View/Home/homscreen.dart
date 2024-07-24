import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskpro_user/View/Authentication/loginscreen.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';
import 'package:taskpro_user/Widget/showwidget.dart';

class Homscreen extends StatefulWidget {
  const Homscreen({super.key});

  @override
  State<Homscreen> createState() => _HomscreenState();
}

class _HomscreenState extends State<Homscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 360,
                    child: PreferredSize(
                        preferredSize: const Size(0, 0),
                        child: AppBar(
                            leading: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.location_on),
                                SizedBox(height: 4),
                                Customtext(text: 'Mavoor'),
                              ],
                            ),
                            actions: const [
                              Row(children: [
                                Icon(Icons.notifications),
                                SizedBox(width: 20),
                                CircleAvatar()
                              ])
                            ]))),
                const SizedBox(height: 20),
                const Customtext(
                    text: 'Top rated',
                    fontWeight: FontWeight.bold,
                    fontsize: 16),
                const SizedBox(height: 10),
                const Expanded(
                    flex: 2,
                    child: Customestreambuilder(
                      cardtype: 'maincard',
                    )),
                const SizedBox(height: 7.8),
                const Customtext(
                    text: 'Nearby your location',
                    fontWeight: FontWeight.bold,
                    fontsize: 16),
                const SizedBox(height: 10),
                const Expanded(
                    flex: 1,
                    child: Customestreambuilder(cardtype: 'secondcard')),
              ])),
    );
  }
}
