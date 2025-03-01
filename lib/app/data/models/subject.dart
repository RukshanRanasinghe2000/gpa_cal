class Subject {
  final int? id;
  final String? sem;
  final String? code;
  final String? subjectName;
  final String? grade;
  final String? credit;

  Subject({this.id, this.sem, this.code, required this.subjectName,
    required this.grade, this.credit,});

  Map<String, dynamic> toMap() {
    return {'id': id, 'sem': sem, 'code': code,
      'subjectName': subjectName, 'grade': grade, 'credit':credit};
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'],
      sem: map['sem'],
      subjectName: map['subjectName'],
      code: map['code'],
      credit: map['credit'],
      grade: map['grade'],
    );
  }
}
