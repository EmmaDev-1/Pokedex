class Region {
  final String name;
  final String url;
  final String generationUrl;
  final String imageUrl;

  Region({
    required this.name,
    required this.url,
    required this.generationUrl,
    required this.imageUrl,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    String regionName = json['name'] ?? 'Unknown';
    return Region(
      name: regionName,
      url: json['url'] ?? '',
      generationUrl:
          json['main_generation'] != null ? json['main_generation']['url'] : '',
      imageUrl: _getRegionImageUrl(
          regionName), // Añade esto para inicializar el campo imageUrl
    );
  }

  static String _getRegionImageUrl(String regionName) {
    // Mapa de nombres de regiones a URLs de imágenes
    const Map<String, String> regionImages = {
      'kanto': 'assets/images/regions/kanto.jpg',
      'johto': 'assets/images/regions/johto.jpg',
      'hoenn': 'assets/images/regions/hoenn.jpg',
      'sinnoh': 'assets/images/regions/sinnoh.jpg',
      'unova': 'assets/images/regions/unova.jpg',
      'kalos': 'assets/images/regions/kalos.jpg',
      'alola': 'assets/images/regions/alola.jpg',
      'galar': 'assets/images/regions/galar.jpg',
      'hisui': 'assets/images/regions/hisui.jpg',
      'paldea': 'assets/images/regions/paldea.jpg',
      // Añade más regiones según sea necesario
    };
    return regionImages[regionName] ??
        'assets/images/regions/kanto.jpg'; // URL de imagen por defecto
  }
}
