import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/View/Home/workerproflle.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';

void showCustomSnackBar(BuildContext context,
    {String msg = '', String title = '', Color bgcolor = primarycolour}) {
  Get.snackbar(
    title,
    msg,
    colorText: Colors.white,
    backgroundColor: bgcolor,
    duration: const Duration(seconds: 4),
    snackPosition: SnackPosition.BOTTOM,
    borderRadius: 20,
    titleText: Text(
      title,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    messageText: Center(
      child: Text(
        msg,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
  );
}

class Customeanimatedcontainer extends StatelessWidget {
  const Customeanimatedcontainer(
      {super.key,
      required this.width,
      this.height = 80,
      this.borderRadius,
      this.child,
      this.color = Colors.transparent});
  final double width;
  final double height;
  final Color color;
  final BorderRadius? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(seconds: 2),
        curve: Curves.fastLinearToSlowEaseIn,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius ?? BorderRadius.circular(0),
        ),
        alignment: Alignment.center,
        child: child ?? const SizedBox());
  }
}

class Customcard extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> ratedwoker;
  final String cardtype;

  const Customcard(
      {super.key, required this.ratedwoker, required this.cardtype});

  @override
  Widget build(BuildContext context) {
    if (cardtype == 'maincard') {
      return CarouselSlider.builder(
          itemBuilder: (context, index, realIndex) {
            var worker = ratedwoker[index].data();
            var name = worker['firstName'] + ' ' + worker['lastName'];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Workerproflle(worker: worker)));
              },
              child: Card(
                  shadowColor: Colors.grey,
                  elevation: 3,
                  color: primarycolour.withOpacity(.9),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: SizedBox(
                      width: 330,
                      child: Column(children: [
                        SizedBox(
                            width: double.infinity,
                            height: 178,
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: Image.network(worker['profileImageUrl'],
                                    fit: BoxFit.cover))),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Customtext(
                                        text: worker['workType'],
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontsize: 16),
                                    Customtext(text: name, color: Colors.white),
                                    Customtext(
                                        text: worker['maxQualification'],
                                        color: Colors.white),
                                    Customtext(
                                        text: worker['email'],
                                        color: Colors.white)
                                  ])
                            ]))
                      ]))),
            );
          },
          itemCount: ratedwoker.length,
          options: CarouselOptions(
              height: 380,
              aspectRatio: 16 / 9,
              autoPlay: true,
              reverse: false,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              initialPage: 0));
    } else {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var worker = ratedwoker[index].data();
          var name = worker['firstName'] + ' ' + worker['lastName'];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Workerproflle(worker: worker)));
            },
            child: Card(
                shadowColor: Colors.grey,
                elevation: 3,
                color: primarycolour.withOpacity(.9),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: SizedBox(
                    height: 200,
                    width: 340,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              width: 98,
                              height: 98,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                child: Image.network(worker['profileImageUrl'],
                                    fit: BoxFit.cover),
                              )),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Customtext(
                                    text: worker['workType'],
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontsize: 16),
                                Customtext(text: name, color: Colors.white),
                                Customtext(
                                    text: worker['maxQualification'],
                                    color: Colors.white),
                                Customtext(
                                    text: worker['email'], color: Colors.white)
                              ])
                        ]))),
          );
        },
        itemCount: ratedwoker.length,
      );
    }
  }
}

class Customestreambuilder extends StatelessWidget {
  final String cardtype;
  const Customestreambuilder({
    super.key,
    required this.cardtype,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('workers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              var ratedwoker = snapshot.data!.docs
                  .where((doc) => doc['registerd'] == 'Accepted')
                  .toList();
              if (ratedwoker.isEmpty) {
                return Center(
                    child: SizedBox(
                        height: 250,
                        width: 150,
                        child: Column(children: [
                          Image.asset(
                            'lib/Asset/no-data.png',
                            height: 120,
                          ),
                          const Customtext(text: 'No worker')
                        ])));
              } else {
                return Customcard(ratedwoker: ratedwoker, cardtype: cardtype);
              }
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.hasError.toString()));
            } else {
              return Center(
                  child: SizedBox(
                      height: 250,
                      width: 150,
                      child: Column(children: [
                        Image.asset(
                          'lib/Asset/no-data.png',
                          height: 120,
                        ),
                        const Customtext(text: 'Noworker')
                      ])));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
