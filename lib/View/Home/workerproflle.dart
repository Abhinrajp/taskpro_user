import 'package:flutter/material.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';

class Workerproflle extends StatefulWidget {
  final Map<String, dynamic> worker;
  const Workerproflle({super.key, required this.worker});

  @override
  State<Workerproflle> createState() => _WorkerproflleState();
}

class _WorkerproflleState extends State<Workerproflle> {
  @override
  Widget build(BuildContext context) {
    var name = widget.worker['firstName'] + ' ' + widget.worker['lastName'];
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.9),
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: const Offset(2, 3))
              ]),
          height: 390,
          width: double.infinity,
          child: Stack(fit: StackFit.expand, children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                child: Image.network(widget.worker['profileImageUrl'],
                    fit: BoxFit.cover)),
            Positioned(
                left: 20,
                top: 50,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(.5),
                      child:
                          const Icon(Icons.arrow_back, color: primarycolour)),
                ))
          ])),
      const SizedBox(height: 40),
      Customtext(
          text: widget.worker['workType'],
          fontsize: 20,
          fontWeight: FontWeight.bold),
      const SizedBox(height: 20),
      SizedBox(
          width: 340,
          child: Customtext(
            text: widget.worker['about'],
          )),
      const SizedBox(height: 20),
      Row(children: [
        Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Customtext(text: name, fontWeight: FontWeight.bold, fontsize: 14),
              const SizedBox(height: 10),
              SizedBox(
                width: 340,
                child: Customtext(
                    text: widget.worker['location'],
                    fontWeight: FontWeight.bold,
                    fontsize: 14),
              ),
              const SizedBox(height: 10),
              Customtext(
                  text: widget.worker['maxQualification'],
                  fontWeight: FontWeight.bold,
                  fontsize: 14),
              const SizedBox(height: 10),
              // Customtext(
              //     text: widget.worker['totalwork'],
              //     fontWeight: FontWeight.bold,
              //     fontsize: 14),
              const SizedBox(height: 30),
              Column(children: [
                Row(children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.star_outline_outlined)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.star_outline_outlined)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.star_outline_outlined)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.star_outline_outlined)),
                ]),
                const Customtext(text: 'Rate Now'),
                const SizedBox(height: 30),
                Row(children: [
                  const SizedBox(width: 10),
                  Connectbutton(
                      onpress: () {},
                      text: 'Connect',
                      icon: const Icon(Icons.connect_without_contact_rounded,
                          color: Colors.white)),
                  const SizedBox(width: 20),
                  Connectbutton(
                      onpress: () {},
                      text: 'Schedule',
                      icon: const Icon(Icons.calendar_today_rounded,
                          color: Colors.white))
                ])
              ])
            ]))
      ])
    ])));
  }
}
