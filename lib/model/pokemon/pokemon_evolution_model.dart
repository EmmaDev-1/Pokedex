class Evolution {
  final String name;
  final String imageUrl;

  Evolution({required this.name, required this.imageUrl});

  factory Evolution.fromJson(Map<String, dynamic> json) {
    return Evolution(
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
    );
  }
}
