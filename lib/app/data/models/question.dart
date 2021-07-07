
class Question {
  Question({
    this.nro = 0,
    this.selectAmount = 0,
    this.isDynamic = false,
    this.allowSelectFavoriteAnswer = false,
    this.isActive = false,
    this.version = 0,
    this.questionType = '',
    this.labels = const [],
    this.answers = const [],
    this.filterMemberships = const [],
  });

  int nro;
  int selectAmount;
  bool isDynamic;
  bool allowSelectFavoriteAnswer;
  bool isActive;
  int version;
  String questionType;
  List<Label> labels;
  List<Answer> answers;
  List<FilterMembership> filterMemberships;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    nro: json["nro"],
    selectAmount: json["selectAmount"],
    isDynamic: json["isDynamic"],
    allowSelectFavoriteAnswer: json["allowSelectFavoriteAnswer"],
    isActive: json["isActive"],
    version: json["version"],
    questionType: json["questionType"],
    labels: List<Label>.from(json["labels"].map((x) => Label.fromJson(x))),
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
    filterMemberships: List<FilterMembership>.from(json["filterMemberships"].map((x) => FilterMembership.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nro": nro,
    "selectAmount": selectAmount,
    "isDynamic": isDynamic,
    "allowSelectFavoriteAnswer": allowSelectFavoriteAnswer,
    "isActive": isActive,
    "version": version,
    "questionType": questionType,
    "labels": List<dynamic>.from(labels.map((x) => x.toJson())),
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
    "filterMemberships": List<dynamic>.from(filterMemberships.map((x) => x.toJson())),
  };
}

class Answer {
  Answer({
    this.aNro = 0,
    this.qNro = 0,
    this.isOk = false,
    this.isActive = false,
    this.version = 0,
    this.labels = const [],
  });

  int aNro;
  int qNro;
  bool isOk;
  bool isActive;
  int version;
  List<Label> labels;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    aNro: json["aNro"],
    qNro: json["qNro"],
    isOk: json["isOk"],
    isActive: json["isActive"],
    version: json["version"],
    labels: List<Label>.from(json["labels"].map((x) => Label.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "aNro": aNro,
    "qNro": qNro,
    "isOk": isOk,
    "isActive": isActive,
    "version": version,
    "labels": List<dynamic>.from(labels.map((x) => x.toJson())),
  };
}

class Label {
  Label({
    this.code = '',
    this.text = '',
    this.fileName = '',
    this.filePath = '',
    this.hasAudio = false,
  });

  String code;
  String text;
  String fileName;
  String filePath;
  bool hasAudio;

  factory Label.fromJson(Map<String, dynamic> json) => Label(
    code: json["code"],
    text: json["text"],
    fileName: json["fileName"],
    filePath: json["filePath"],
    hasAudio: json["hasAudio"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "text": text,
    "fileName": fileName,
    "filePath": filePath,
    "hasAudio": hasAudio,
  };
}

class FilterMembership {
  FilterMembership({
    this.filter = '',
    this.value = '',
  });

  String filter;
  String value;

  factory FilterMembership.fromJson(Map<String, dynamic> json) => FilterMembership(
    filter: json["filter"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "filter": filter,
    "value": value,
  };
}
