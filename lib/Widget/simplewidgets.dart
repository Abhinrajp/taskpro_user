import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskpro_user/Utility/consts.dart';

class Customtext extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontsize;
  final Color color;
  final TextOverflow overflow;
  const Customtext(
      {super.key,
      required this.text,
      this.fontWeight = FontWeight.normal,
      this.fontsize = 12,
      this.color = Colors.black,
      this.overflow = TextOverflow.visible});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: GoogleFonts.cabin(
          fontSize: fontsize, fontWeight: fontWeight, color: color),
    );
  }
}

class Customformfield extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String hintext;
  final Icon icon;
  final TextInputType keybordtype;
  const Customformfield(
      {super.key,
      required this.hintext,
      required this.icon,
      required this.controller,
      required this.validator,
      this.keybordtype = TextInputType.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        validator: validator,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: icon,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: primarycolour),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.red),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          label: Customtext(text: hintext, fontsize: 14),
        ),
      ),
    );
  }
}

class Customsubmitbutton extends StatelessWidget {
  final Function ontap;
  final Size size;
  final Widget widget;
  final Color color;

  const Customsubmitbutton(
      {super.key,
      required this.widget,
      required this.size,
      required this.ontap,
      this.color = primarycolour});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(color.withOpacity(.9)),
                minimumSize: WidgetStatePropertyAll(size)),
            onPressed: () {
              ontap();
            },
            child: widget));
  }
}

class Connectbutton extends StatelessWidget {
  final String text;
  final Icon icon;
  final VoidCallback onpress;
  const Connectbutton({
    super.key,
    required this.text,
    required this.icon,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: primarycolour.withOpacity(.9),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            minimumSize: const Size(160, 60),
            textStyle: const TextStyle(fontSize: 12)),
        onPressed: onpress,
        child: Row(children: [
          Customtext(text: text, color: Colors.white),
          const SizedBox(width: 11),
          icon
        ]));
  }
}

class Customprofileformfeild extends StatelessWidget {
  final FontWeight fontWeight;
  final double fontsize;
  final Function(String)? onChanged;
  const Customprofileformfeild(
      {super.key,
      required this.namecontroller,
      this.fontWeight = FontWeight.normal,
      this.fontsize = 12,
      required this.onChanged});

  final TextEditingController namecontroller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.cabin(
          color: Colors.white, fontSize: fontsize, fontWeight: fontWeight),
      onChanged: onChanged,
      controller: namecontroller,
      decoration: const InputDecoration(
          label: Customtext(
            text: 'Name',
            color: Colors.white,
          ),
          border: OutlineInputBorder(borderSide: BorderSide())),
    );
  }
}
