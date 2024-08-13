import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskpro_user/Services/chatservices.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/View/screens/chat/messagescreen.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';

class Chathistoryscreen extends StatefulWidget {
  const Chathistoryscreen({super.key});

  @override
  State<Chathistoryscreen> createState() => _ChathistoryscreenState();
}

class _ChathistoryscreenState extends State<Chathistoryscreen> {
  @override
  Widget build(BuildContext context) {
    final currentuser = FirebaseAuth.instance.currentUser!.uid;
    Chatservices chatservices = Chatservices();
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Customtext(
            text: 'Messages',
            fontWeight: FontWeight.bold,
            fontsize: 22,
            color: primarycolour,
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chat_rooms')
              .where('participants', arrayContains: currentuser)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 110),
                    child: Image.asset('lib/Asset/nomsg.png'),
                  ),
                  const Customtext(
                    text: 'No messages',
                    fontWeight: FontWeight.bold,
                    fontsize: 15,
                  ),
                  const Customtext(
                    text: 'Try to connect with someone',
                    fontWeight: FontWeight.bold,
                    fontsize: 13,
                  ),
                ],
              ));
            }
            final List<DocumentSnapshot> chatrooms = snapshot.data!.docs;
            final Set<String> otheruserid = {};
            for (var chatroom in chatrooms) {
              final List<dynamic> participates = chatroom['participants'];
              participates.forEach(
                (participant) {
                  if (participant != currentuser) {
                    otheruserid.add(participant);
                  }
                },
              );
            }
            return FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('workers')
                  .where(FieldPath.documentId, whereIn: otheruserid.toList())
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Customtext(text: 'No messages');
                }
                final List<DocumentSnapshot> users = snapshot.data!.docs;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final userdata = users[index];
                    final String userid = userdata.id;
                    final username =
                        userdata['firstName'] + ' ' + userdata['lastName'];
                    final userimage = userdata['profileImageUrl'];
                    return FutureBuilder(
                      future: chatservices.getlastmessage(currentuser, userid),
                      builder: (context, snapshot) {
                        String lastmessage = '';
                        String lastMessageTime = '';
                        if (snapshot.hasData) {
                          final lastmessagedata =
                              snapshot.data!.data() as Map<String, dynamic>?;
                          if (lastmessagedata != null) {
                            final Timestamp timestamp =
                                lastmessagedata['timestamp'];
                            lastMessageTime = DateFormat('hh:mm a')
                                .format(timestamp.toDate());
                            lastmessage = lastmessagedata['message'] ?? '';
                          }
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Messagescreen(
                                        worker: userdata.data()
                                            as Map<String, dynamic>)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: ListTile(
                              minLeadingWidth: 35,
                              leading: CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(userimage),
                              ),
                              title: Customtext(
                                text: username,
                                fontWeight: FontWeight.bold,
                                fontsize: 14,
                              ),
                              subtitle: Customtext(
                                text: lastmessage,
                                fontsize: 12,
                                color: Colors.grey,
                              ),
                              trailing: Customtext(text: lastMessageTime),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  itemCount: users.length,
                );
              },
            );
          },
        ));
  }
}
