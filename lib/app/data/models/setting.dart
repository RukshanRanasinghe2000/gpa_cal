class Settings {
  final String grade;
  final double gpaValue;

  Settings({required this.grade, required this.gpaValue});

  Map<String, dynamic> toMap() {
    return {
      'grade': grade,
      'gpaValue': gpaValue,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      grade: map['grade'],
      gpaValue: map['gpaValue'],
    );
  }
}
