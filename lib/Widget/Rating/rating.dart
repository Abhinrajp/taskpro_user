import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:taskpro_user/Widget/Popups/showwidget.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';

class Ratingofworker {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  ratingbox(BuildContext context, Map<String, dynamic> worker) {
    double rating = 0;
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                backgroundColor: Colors.white.withOpacity(.9),
                title: const Padding(
                    padding: EdgeInsets.only(left: 55),
                    child: Customtext(
                        text: 'Rate this worker',
                        fontWeight: FontWeight.bold,
                        fontsize: 16)),
                content: RatingBar.builder(
                    itemPadding: const EdgeInsets.only(left: 8, top: 8),
                    minRating: 1,
                    maxRating: 5,
                    itemBuilder: (context, _) =>
                        const Icon(size: 8, Icons.star, color: Colors.amber),
                    updateOnDrag: true,
                    glow: true,
                    onRatingUpdate: (value) {
                      rating = value;
                    }),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Customtext(
                          text: 'Not now',
                          fontWeight: FontWeight.w300,
                          fontsize: 14)),
                  TextButton(
                      onPressed: () async {
                        double value = double.parse(worker['rating']);
                        String newval = (value + rating).toString();
                        await firestore
                            .collection('workers')
                            .doc(worker['id'])
                            .update({'rating': newval});
                        showCustomSnackBar(
                            title: 'Rating success', msg: 'Rated this worker');
                        Navigator.pop(context);
                      },
                      child: const Customtext(
                          text: 'Done',
                          fontWeight: FontWeight.w300,
                          fontsize: 14))
                ]));
  }
}
