import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskpro_user/Controller/schedulecontroller.dart';
import 'package:taskpro_user/View/Home/workerproflle.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';

class Schdulescreen extends StatefulWidget {
  const Schdulescreen({super.key});

  @override
  State<Schdulescreen> createState() => _SchdulescreenState();
}

Schedulecontroller schedulecontroller = Get.put(Schedulecontroller());

class _SchdulescreenState extends State<Schdulescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar(context),
      body: body(),
    );
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Customtext(
          text: 'Scheduled works', fontsize: 20, fontWeight: FontWeight.bold),
      centerTitle: true);
}

Widget body() {
  return StreamBuilder(
      stream: schedulecontroller.schedulestream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Padding(
              padding: const EdgeInsets.only(left: 80),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 220,
                        width: 220,
                        child: Image.asset('lib/Asset/Schedule.gif')),
                    const Customtext(
                        text: 'No Scheduled works',
                        fontWeight: FontWeight.bold,
                        fontsize: 17)
                  ]));
        }
        var schedule = snapshot.data;
        return Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: ListView.builder(
              itemBuilder: (context, index) {
                var worker = schedule[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Workerproflle(worker: worker)));
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: Card(
                            color: Colors.grey.withOpacity(.2),
                            elevation: 0,
                            child: SizedBox(
                              height: 90,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 20),
                                    CircleAvatar(
                                        radius: 34,
                                        backgroundImage: NetworkImage(
                                            worker['profileImageUrl'])),
                                    const SizedBox(width: 30),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Customtext(
                                              text:
                                                  '${worker['firstName']} ${worker['lastName']}',
                                              fontWeight: FontWeight.bold,
                                              fontsize: 13),
                                          Customtext(
                                              text: worker['workType'],
                                              color:
                                                  Colors.black.withOpacity(.6),
                                              fontWeight: FontWeight.w500,
                                              fontsize: 13),
                                          Row(children: [
                                            const Icon(
                                              Icons.calendar_month_outlined,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 10),
                                            Customtext(
                                                text: worker['date'],
                                                color: Colors.grey)
                                          ])
                                        ])
                                  ]),
                            ))));
              },
              itemCount: schedule!.length),
        );
      });
}
