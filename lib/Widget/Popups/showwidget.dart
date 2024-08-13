import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskpro_user/Controller/appstatecontroller.dart';
import 'package:taskpro_user/Controller/wishlistcontroller.dart';
import 'package:taskpro_user/Function/customfunctions.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/View/Authentication/login/loginscreen.dart';
import 'package:taskpro_user/View/Home/workerproflle.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';

void showCustomSnackBar(
    {String msg = '', String title = '', Color bgcolor = primarycolour}) {
  Get.snackbar(title, msg,
      colorText: Colors.white,
      backgroundColor: bgcolor,
      duration: const Duration(seconds: 4),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 20,
      titleText: Text(title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center),
      messageText: Center(
          child: Text(msg,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3));
}

final Customfunctions customfunctions = Customfunctions();

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
            borderRadius: borderRadius ?? BorderRadius.circular(0)),
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
    final Wishlistcontroller wishlistcontroller = Get.find();
    if (cardtype == 'maincard') {
      return CarouselSlider.builder(
          itemBuilder: (context, index, realIndex) {
            var worker = ratedwoker[index].data();
            var name = worker['firstName'] + ' ' + worker['lastName'];
            var totalrating = customfunctions.ratingfunction(
                worker['rating'], worker['totalwork']);
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
                        child: Stack(children: [
                          Column(children: [
                            SizedBox(
                                width: double.infinity,
                                height: 178,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: Image.network(
                                        worker['profileImageUrl'],
                                        fit: BoxFit.cover))),
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Customtext(
                                          text: worker['workType'],
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontsize: 16),
                                      Customtext(
                                          text: name, color: Colors.white),
                                      Customtext(
                                          text: worker['maxQualification'],
                                          color: Colors.white),
                                      Customtext(
                                          text: worker['email'],
                                          color: Colors.white),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Customtext(
                                                text: 'Rating  :',
                                                color: Colors.white),
                                            Customtext(
                                                fontWeight: FontWeight.bold,
                                                fontsize: 15,
                                                text: '$totalrating / 5',
                                                color: Colors.white)
                                          ])
                                    ]))
                          ]),
                          Positioned(
                              left: 220,
                              top: 180,
                              child: StreamBuilder(
                                  stream: wishlistcontroller.wishliststream,
                                  builder: (context, snapshot) {
                                    bool isinwishlist = snapshot.data?.any(
                                            (item) =>
                                                item['id'] == worker['id']) ??
                                        false;
                                    return IconButton(
                                        onPressed: () {
                                          if (isinwishlist) {
                                            wishlistcontroller
                                                .removefromwishlist(worker);
                                            showCustomSnackBar(
                                                title: 'Removed from favourite',
                                                msg:
                                                    'Worker removed from favourite');
                                          } else {
                                            wishlistcontroller
                                                .addtowishlist(worker);
                                            showCustomSnackBar(
                                                title: 'Added to favourite',
                                                msg:
                                                    'Worker added to favourite');
                                          }
                                        },
                                        icon: Icon(
                                            isinwishlist
                                                ? Icons.favorite
                                                : Icons
                                                    .favorite_border_outlined,
                                            color: Colors.white));
                                  })),
                        ]))));
          },
          itemCount: ratedwoker.length,
          options: CarouselOptions(
              height: 393,
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Card(
                      shadowColor: Colors.grey,
                      elevation: 3,
                      color: primarycolour.withOpacity(.9),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: SizedBox(
                          height: 100,
                          width: 345,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                    width: 98,
                                    height: 98,
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        child: Image.network(
                                            worker['profileImageUrl'],
                                            fit: BoxFit.cover))),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Customtext(
                                          text: worker['workType'],
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontsize: 16),
                                      Customtext(
                                          text: name, color: Colors.white),
                                      Customtext(
                                          text: worker['maxQualification'],
                                          color: Colors.white),
                                      Customtext(
                                          text: worker['email'],
                                          color: Colors.white)
                                    ])
                              ]))),
                ));
          },
          itemCount: ratedwoker.length);
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
                          Image.asset('lib/Asset/no-data.png', height: 120),
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
                        Image.asset('lib/Asset/no-data.png', height: 120),
                        const Customtext(text: 'Noworker')
                      ])));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class CustomImageButton extends StatelessWidget {
  const CustomImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    final Appstatecontroller appstatecontroller =
        Get.find<Appstatecontroller>();

    Future<void> pickImage(ImageSource source) async {
      try {
        final XFile? pickedFile = await picker.pickImage(source: source);
        if (pickedFile != null) {
          final imageFile = File(pickedFile.path);
          appstatecontroller.setImageFile(imageFile);
        } else {
          log("No image selected.");
        }
      } catch (e) {
        log("Error picking image: $e");
      }
    }

    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => Padding(
                  padding: const EdgeInsets.only(left: 65, right: 65),
                  child: Dialog(
                      backgroundColor: Colors.black,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  await pickImage(ImageSource.camera);
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.camera_alt_outlined,
                                    size: 45, color: Colors.white)),
                            IconButton(
                                onPressed: () async {
                                  await pickImage(ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.image_outlined,
                                    size: 45, color: Colors.white))
                          ]))));
        },
        icon: const Icon(Icons.camera_alt_outlined,
            color: Colors.white, size: 31));
  }
}

void alertboxforconfirmation(BuildContext context, Function fun) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
              backgroundColor: primarycolour,
              title: const Text('Are you sure',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              content: const Text('Do you want to Logout ?',
                  style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      log('logout clicked on the lerbox');
                      fun();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Loginscreen()),
                          (route) => false);
                    },
                    child: const Text('Yes')),
                ElevatedButton(
                    onPressed: () {
                      log("clicked");
                      Navigator.pop(context);
                    },
                    child: const Text('No'))
              ]));
}
