class ChampionModel {
  final String id;
  final String key;
  final String name;
  final Map image;

  ChampionModel({
    required this.id,
    required this.key,
    required this.name,
    required this.image,
  });

  ChampionModel.fromMap({required Map<String, dynamic> map})
      : id = map['id'] ?? '',
        key = map['key'] ?? '',
        name = map['name'] ?? '',
        image = map['image'] ?? '';
}
