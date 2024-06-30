class Move {
  final String name;
  final String type;
  final String description;

  Move({required this.name, required this.type, required this.description});

  factory Move.fromJson(Map<String, dynamic> json) {
    return Move(
      name: json['name'],
      type: json['type']['name'],
      description:
          json['effect_entries'][0]['short_effect'].replaceAll('\n', ' '),
    );
  }
}
