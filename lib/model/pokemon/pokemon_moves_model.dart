class MoveDetail {
  final String name;
  final String type;
  final int power;
  final int accuracy;
  final String effect;

  MoveDetail({
    required this.name,
    required this.type,
    required this.power,
    required this.accuracy,
    required this.effect,
  });

  factory MoveDetail.fromJson(Map<String, dynamic> json) {
    String effect = '';
    if (json['flavor_text_entries'] != null) {
      final flavorTextEntries = json['flavor_text_entries'] as List;
      final flavorTextEntry = flavorTextEntries.firstWhere(
        (entry) => entry['language']['name'] == 'en',
        orElse: () => null,
      );
      if (flavorTextEntry != null) {
        effect = flavorTextEntry['flavor_text'].replaceAll('\n', ' ');
      }
    }

    return MoveDetail(
      name: json['name'],
      type: json['type']['name'],
      power: json['power'] ?? 0,
      accuracy: json['accuracy'] ?? 0,
      effect: effect,
    );
  }
}
