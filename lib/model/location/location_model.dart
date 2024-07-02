class Location {
  final int id;
  final String name;
  final String region;

  Location({
    required this.id,
    required this.name,
    required this.region,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      region: json['region']['name'],
    );
  }
}
