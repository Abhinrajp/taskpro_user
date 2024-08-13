import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:taskpro_user/Services/chatservices.dart';
import 'package:taskpro_user/Services/paymentservices.dart';
import 'package:taskpro_user/View/Home/workerproflle.dart';
import 'package:taskpro_user/Widget/message/messagewidget.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';

class Messagescreen extends StatefulWidget {
  final Map<String, dynamic> worker;
  const Messagescreen({super.key, required this.worker});

  @override
  State<Messagescreen> createState() => _MessagescreenState();
}

final Messagewidget messagewidget = Messagewidget();

class _MessagescreenState extends State<Messagescreen> {
  final messagecontroller = TextEditingController();
  final Chatservices chatservices = Chatservices();
  final Paymentservices paymentservices = Paymentservices();
  late Razorpay razorpay;
  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentservices.paymentsucess(context, response, widget.worker);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    paymentservices.paymentfailed(context, response);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    paymentservices.externalwaller(context, response);
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  void sendmessage() async {
    var name = widget.worker['firstName'] + ' ' + widget.worker['lastName'];
    if (messagecontroller.text.isNotEmpty) {
      chatservices.sendmessage(
          widget.worker['id'], name, messagecontroller.text, 'text');
      messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    var name = widget.worker['firstName'] + ' ' + widget.worker['lastName'];
    return Scaffold(
        appBar: appbar(name),
        body: Column(children: [
          const SizedBox(height: 20),
          Expanded(child: messagewidget.messagelist(widget.worker, razorpay)),
          messagewidget.inputmessage(messagecontroller, sendmessage)
        ]));
  }

  AppBar appbar(String name) {
    return AppBar(
        elevation: 0,
        leadingWidth: 350,
        leading: Row(children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          const SizedBox(width: 20),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Workerproflle(worker: widget.worker)));
              },
              child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.worker['profileImageUrl']))),
          const SizedBox(width: 20),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Workerproflle(worker: widget.worker)));
              },
              child: Customtext(text: name, fontWeight: FontWeight.bold))
        ]),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call_rounded)),
          const SizedBox(width: 20)
        ]);
  }
}
