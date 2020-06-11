
import 'dart:convert';
import 'dart:async' show Future;
import 'package:assesmentexample/network/Questions.dart';
import 'package:flutter/services.dart' show rootBundle;

class QuestionsRepo{
Future<List<Questions>> loadAsset() async {
   final response = await rootBundle.loadString('assets/questions.json');
   final jsonResponse = json.decode(response);
   return new QuestionModel.fromJson(jsonResponse).questions;
}
}