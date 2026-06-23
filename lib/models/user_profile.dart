class UserProfile {
  final String uid;
  final String name;
  final String email;
  final double weight;
  final double height;
  final String primarySport;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.weight,
    required this.height,
    required this.primarySport,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'weight': weight,
      'height': height,
      'primarySport': primarySport,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      weight: (map['weight'] as num).toDouble(),
      height: (map['height'] as num).toDouble(),
      primarySport: map['primarySport'] ?? 'Lari',
    );
  }
}
