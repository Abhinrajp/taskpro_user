import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskpro_user/Controller/wishlistcontroller.dart';
import 'package:taskpro_user/Function/customfunctions.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/View/screens/chat/messagescreen.dart';
import 'package:taskpro_user/Widget/Popups/showwidget.dart';
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
    final Customfunctions customfunctions = Customfunctions();
    final Wishlistcontroller wishlistcontroller = Get.find();
    var name = widget.worker['firstName'] + ' ' + widget.worker['lastName'];
    var rating = customfunctions.ratingfunction(
        widget.worker['rating'], widget.worker['totalwork']);
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
                        child: const Icon(Icons.arrow_back,
                            color: primarycolour))))
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
              Row(children: [
                const Customtext(
                    text: 'Total works  :   ',
                    fontWeight: FontWeight.bold,
                    fontsize: 14),
                Customtext(
                    text: widget.worker['totalwork'],
                    fontWeight: FontWeight.bold,
                    fontsize: 14)
              ]),
              const SizedBox(height: 30),
              Column(children: [
                Row(children: [
                  Column(children: [
                    Row(children: [
                      const Customtext(
                          text: 'Rating  :  ',
                          fontWeight: FontWeight.bold,
                          fontsize: 14),
                      Customtext(
                          text: '$rating / 5',
                          fontWeight: FontWeight.bold,
                          fontsize: 16)
                    ]),
                    const SizedBox(height: 23),
                    Row(children: [
                      StreamBuilder(
                          stream: wishlistcontroller.wishliststream,
                          builder: (context, snapshot) {
                            bool isinwishlist = snapshot.data?.any((item) =>
                                    item['id'] == widget.worker['id']) ??
                                false;
                            return Connectbutton(
                                onpress: () {
                                  if (isinwishlist) {
                                    wishlistcontroller
                                        .removefromwishlist(widget.worker);
                                    showCustomSnackBar(
                                        title: 'Removed from favourite',
                                        msg: 'Worker removed from favourite');
                                  } else {
                                    wishlistcontroller
                                        .addtowishlist(widget.worker);
                                    showCustomSnackBar(
                                        title: 'Added to favourite',
                                        msg: 'Worker added to favourite');
                                  }
                                },
                                text: isinwishlist ? 'Remove' : 'Favourite',
                                icon: Icon(
                                    isinwishlist
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: Colors.white));
                          }),
                      const SizedBox(width: 23),
                      Connectbutton(
                          onpress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Messagescreen(worker: widget.worker)));
                          },
                          text: 'Connect',
                          icon: const Icon(
                              Icons.connect_without_contact_rounded,
                              color: Colors.white))
                    ])
                  ])
                ])
              ])
            ]))
      ])
    ])));
  }
}
