class Experience {
  final String time;
  final String role;
  final String company;
  final String desc;

  Experience({
    required this.time,
    required this.role,
    required this.company,
    required this.desc,
  });

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      time: map['time'] ?? '',
      role: map['role'] ?? '',
      company: map['company'] ?? '',
      desc: map['desc'] ?? '',
    );
  }
}

