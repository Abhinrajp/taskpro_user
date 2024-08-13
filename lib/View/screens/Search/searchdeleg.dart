import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskpro_user/Controller/searchcontroller.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/View/Home/workerproflle.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';

class Searchupdateclass extends SearchDelegate {
  final Searchcontroller searchController = Get.put(Searchcontroller());
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20.0),
            )),
        hintColor: Colors.grey,
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            toolbarTextStyle: TextStyle(color: Colors.black)));
  }

  List workerdata = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: searchController.searchstream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // if (!snapshot.hasData || snapshot.data!.isEmpty) {
        //   return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //     SizedBox(
        //         height: 220,
        //         width: 220,
        //         child: Image.asset('lib/Asset/Emptyfav.png')),
        //     const Customtext(
        //         text: 'Search a worker',
        //         fontWeight: FontWeight.bold,
        //         fontsize: 17),
        //     const Customtext(
        //         text: 'for your need',
        //         fontWeight: FontWeight.bold,
        //         fontsize: 12)
        //   ]);
        // }
        var workers = snapshot.data;
        final filterd = workers!
            .where((element) =>
                element['workType'].toLowerCase().contains(query.toLowerCase()))
            .toList();
        if (filterd.isEmpty) {
          return const Center(
            child: Customtext(text: 'No workers'),
          );
        }
        return ListView.builder(
            itemBuilder: (context, index) {
              var worker = filterd[index];
              var name = worker['firstName'] + ' ' + worker['lastName'];
              var worktypval = worker['workType'].toLowerCase();
              if ((worktypval).contains(query.toLowerCase().trim())) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Workerproflle(worker: worker)));
                    },
                    child: Card(
                        shadowColor: Colors.grey,
                        elevation: 3,
                        color: primarycolour.withOpacity(.9),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: SizedBox(
                            height: 120,
                            width: 340,
                            child: Row(children: [
                              const SizedBox(width: 20),
                              SizedBox(
                                  width: 98,
                                  height: 98,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: Image.network(
                                        worker['profileImageUrl'],
                                        fit: BoxFit.cover),
                                  )),
                              const SizedBox(width: 20),
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
                                        text: worker['email'],
                                        color: Colors.white)
                                  ])
                            ]))));
              }
              return const SizedBox();
            },
            itemCount: filterd.length);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }
}
