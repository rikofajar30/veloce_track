class SportActivity {
  final String id;
  final String sportType;
  final double distanceInKm;
  final int durationInSeconds;
  final String pace;
  final DateTime dateTime;

  SportActivity({
    required this.id,
    required this.sportType,
    required this.distanceInKm,
    required this.durationInSeconds,
    required this.pace,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sportType': sportType,
      'distanceInKm': distanceInKm,
      'durationInSeconds': durationInSeconds,
      'pace': pace,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory SportActivity.fromMap(Map<String, dynamic> map) {
    return SportActivity(
      id: map['id'] ?? '',
      sportType: map['sportType'] ?? 'Lari',
      distanceInKm: (map['distanceInKm'] as num).toDouble(),
      durationInSeconds: map['durationInSeconds'] ?? 0,
      pace: map['pace'] ?? "-'--\"",
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}
