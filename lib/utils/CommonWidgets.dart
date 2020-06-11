import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../AppTheme.dart';

Widget SubmitBtn(String text, Function onSubmit) {
  return MaterialButton(
    onPressed: () {
      onSubmit();
    },
    elevation: 8,
    padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
    splashColor: Colors.white.withOpacity(0.2),
    color: blueDark,
    shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Colors.white, width: 0.5, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(Radius.circular(40))),
    child: Container(
      width: 100,
      alignment: Alignment.center,
      child: Text(text,
          style: GoogleFonts.robotoMono().copyWith(
              color: Colors.white,
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold)),
    ),
  );
}