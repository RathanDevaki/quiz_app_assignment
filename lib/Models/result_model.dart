class ResultModel {
  int? totalScore;
  int? obtainedScore;
  String? uid;

  ResultModel({this.totalScore, this.obtainedScore, this.uid});

  Map<String, dynamic> toMap() {
    return {
      'totalScore': totalScore,
      'obtainedScore': obtainedScore,
      'uid': uid,
    };
  }
}
