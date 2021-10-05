class Practical {
  int? pqCode;
  String? pqNos;
  String? pqPc;
  String? pqQuestion;
  String? pqType;
  int? pqMarks;
  String? pqVersionOfQb;
  String? pqLang;
  String? pqCommonQuestion;
  Null pqNosNavigation;
  Null pqVersionOfQbNavigation;
  List<Null>? tblPracticalResult;

  Practical(
      {this.pqCode,
      this.pqNos,
      this.pqPc,
      this.pqQuestion,
      this.pqType,
      this.pqMarks,
      this.pqVersionOfQb,
      this.pqLang,
      this.pqCommonQuestion,
      this.pqNosNavigation,
      this.pqVersionOfQbNavigation,
      this.tblPracticalResult});

  Practical.fromJson(Map<String, dynamic> json) {
    pqCode = json['pqCode'];
    pqNos = json['pqNos'];
    pqPc = json['pqPc'];
    pqQuestion = json['pqQuestion'];
    pqType = json['pqType'];
    pqMarks = json['pqMarks'];
    pqVersionOfQb = json['pqVersionOfQb'];
    pqLang = json['pqLang'];
    pqCommonQuestion = json['pqCommonQuestion'];
    pqNosNavigation = json['pqNosNavigation'];
    pqVersionOfQbNavigation = json['pqVersionOfQbNavigation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pqCode'] = this.pqCode;
    data['pqNos'] = this.pqNos;
    data['pqPc'] = this.pqPc;
    data['pqQuestion'] = this.pqQuestion;
    data['pqType'] = this.pqType;
    data['pqMarks'] = this.pqMarks;
    data['pqVersionOfQb'] = this.pqVersionOfQb;
    data['pqLang'] = this.pqLang;
    data['pqCommonQuestion'] = this.pqCommonQuestion;
    data['pqNosNavigation'] = this.pqNosNavigation;
    data['pqVersionOfQbNavigation'] = this.pqVersionOfQbNavigation;
    return data;
  }
}
