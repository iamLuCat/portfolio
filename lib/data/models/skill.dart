class Skill {
  final String name;
  final double percent;

  Skill({required this.name, required this.percent});

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      name: map['name'] ?? '',
      percent: (map['percent'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

