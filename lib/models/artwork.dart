class Artwork {

  final int id;
  final String titol;
  final String artista;
  final String data;
  final String tecnica;
  final String departament;
  final String cultura;
  final String dimensions;
  final String imatgePrincipal;
  final String imatgeMiniatura;
  final List<String> imatgesAddicionals;

  Artwork({
    required this.id,
    required this.titol,
    required this.artista,
    required this.data,
    required this.tecnica,
    required this.departament,
    required this.cultura,
    required this.dimensions,
    required this.imatgePrincipal,
    required this.imatgeMiniatura,
    required this.imatgesAddicionals,
  });

  bool get teImatge => imatgePrincipal.isNotEmpty;

  factory Artwork.fromJson(Map<String, dynamic> json) => Artwork(
      id: json['objectID'],
      titol: json['title'] ?? '',
      artista: json['artistDisplayName'] ?? '',
      data: json['objectDate'] ?? '',
      tecnica: json['medium'] ?? '',
      departament: json['department'] ?? '',
      cultura: json['culture'] ?? '',
      dimensions: json['dimensions'] ?? '',
      imatgePrincipal: json['primaryImage'] ?? '',
      imatgeMiniatura: json['primaryImageSmall'] ?? '',
      imatgesAddicionals: List<String>.from(json['additionalImages'] ?? []),
  );
}