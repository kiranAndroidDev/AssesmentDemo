import 'package:assesmentexample/utils/CommonWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../HomePage.dart';

class ResultScreen extends StatelessWidget{
  double _score;
  int _total;

  ResultScreen(this._score, this._total);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 30),
                alignment: Alignment.center,
                child: Text("You have scored", style: GoogleFonts.robotoMono().copyWith(color: Colors.black54, fontSize: 28, fontWeight: FontWeight.bold),),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  child: Text("$_score", style: GoogleFonts.roboto().copyWith(fontSize: 38, color: Colors.black54,fontWeight: FontWeight.w600),),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                alignment: Alignment.center,
                child: Text("Take Test again", style: GoogleFonts.roboto().copyWith(color: Colors.black54, fontSize: 20),)),

              Container(
                margin: EdgeInsets.only(bottom: 30),
                alignment: Alignment.center,
                child: SubmitBtn("Start", (){
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                }),
              ),

            ],
          ),
        ),
      ),
    );
  }

}