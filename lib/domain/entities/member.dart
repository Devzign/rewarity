class Member {
  final String id;
  final String name;
  final int points;
  final bool isTierPremium;

  Member({
    required this.id,
    required this.name,
    required this.points,
    this.isTierPremium = false,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json['id'] as String,
    name: json['name'] as String,
    points: json['points'] as int,
    isTierPremium: json['isTierPremium'] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'points': points,
    'isTierPremium': isTierPremium,
  };
}
