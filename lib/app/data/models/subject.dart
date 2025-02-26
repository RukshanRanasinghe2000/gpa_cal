class Subject {
  final int? id;
  final String? sem;
  final String? code;
  final String? subjectName;
  final double? grade;

  Subject({this.id, this.sem, this.code, required this.subjectName, required this.grade});

  Map<String, dynamic> toMap() {
    return {'id': id, 'sem': sem, 'code': code, 'subjectName': subjectName, 'grade': grade};
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'],
      sem: map['sem'],
      subjectName: map['subjectName'],
      code: map['code'],
      grade: map['grade'],
    );
  }
}
