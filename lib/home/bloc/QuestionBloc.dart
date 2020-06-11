import 'dart:async';

import 'package:assesmentexample/network/Questions.dart';
import 'package:assesmentexample/network/QuestionsRepo.dart';

import '../../network/ApiResponse.dart';

class QuestionBloc{
  QuestionsRepo _repo;
  StreamController _questionsController;

  StreamSink<ApiResponse<List<Questions>>> get questionsSink =>
      _questionsController.sink;

  Stream<ApiResponse<List<Questions>>> get questionsStream =>
      _questionsController.stream;

  QuestionBloc(){
    _questionsController = StreamController<ApiResponse<List<Questions>>>();
    _repo = QuestionsRepo();
  }


  fetchQuestionList() async {
    questionsSink.add(ApiResponse.loading('Fetching Popular Movies'));
    try {
      List<Questions> ques = await _repo.loadAsset();
      questionsSink.add(ApiResponse.completed(ques));
    } catch (e) {
      questionsSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
}