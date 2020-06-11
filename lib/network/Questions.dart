class QuestionModel{
  List<Questions> questions;

  QuestionModel({this.questions});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = new List<Questions>();
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String qId;
  String questions;
  String answerId;
  List<Answeres> answeres;

  Questions({this.qId, this.questions, this.answerId, this.answeres});

  Questions.fromJson(Map<String, dynamic> json) {
    qId = json['qId'];
    questions = json['questions'];
    answerId = json['answerId'];
    if (json['answeres'] != null) {
      answeres = new List<Answeres>();
      json['answeres'].forEach((v) {
        answeres.add(new Answeres.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qId'] = this.qId;
    data['questions'] = this.questions;
    data['answerId'] = this.answerId;
    if (this.answeres != null) {
      data['answeres'] = this.answeres.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answeres {
  String code;
  String value;

  Answeres({this.code, this.value});

  Answeres.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['value'] = this.value;
    return data;
  }
}