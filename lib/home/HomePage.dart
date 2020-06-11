import 'package:assesmentexample/utils/CommonWidgets.dart';
import 'package:assesmentexample/home/bloc/QuestionBloc.dart';
import 'package:assesmentexample/home/result/AssesmentScreen.dart';
import 'package:assesmentexample/network/ApiResponse.dart';
import 'package:assesmentexample/network/Questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<Answeres> answers;
  List<Questions> quesList;
  String _questions;
  String _id;
  int _index = 0;

  String _radioItem;
  QuestionBloc _bloc;
  double _score = 0;

  @override
  void initState() {
    _bloc = QuestionBloc();
    _bloc.fetchQuestionList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: _bloc.questionsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Container(
                      height: 250,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                  break;
                case Status.ERROR:
                  return Container(
                    child: Text("Something went wrong"),
                  );
                  break;
                case Status.COMPLETED:
                  quesList = snapshot.data.data;
                  _questions = quesList[_index].questions;
                  answers = quesList[_index].answeres;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.25,
                              left: 30),
                          alignment: Alignment.centerLeft,
                          child: Text("$_questions",
                              style: TextStyle(fontSize: 23))),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: Column(
                          children: answers
                              .map((data) => RadioListTile(
                                    title: Text("${data.value}"),
                                    groupValue: _id,
                                    value: data.code,
                                    onChanged: (val) {
                                      setState(() {
                                        _radioItem = data.value;
                                        _id = data.code;
                                        print("code $_id  $_radioItem ");
                                      });
                                    },
                                  ))
                              .toList(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: SubmitBtn(
                            (_index == (quesList.length - 1))
                                ? "Finish"
                                : "Next", () {
                          setState(() {
                            if (_id == null) {
                              _score = _score + 0;
                            } else if (_id == quesList[_index].answerId) {
                              _score = _score + 10;
                            } else {
                              _score = _score - 3.3;
                            }
                            print("Score:  $_score");
                            _radioItem = null;
                            _id = null;
                            if (_index <= quesList.length - 2) {
                              _index = _index + 1;
                            } else {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => ResultScreen(
                                          _score, ((_index + 1) * 10))));
                            }
                          });
                        }),
                      )
                    ],
                  );
                  break;
                default:
                  return Container(
                    child: Text("Something went wrong"),
                  );
              }
            } else
              return Container(
                child: Text("Something went wrong"),
              );
          },
        ),
      ),
    );
  }
}
