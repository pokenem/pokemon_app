class PokemonInfo {
  String name;
  int weight;
  int height;
  List<String> types;
  String imageUrl;

  PokemonInfo({
    required this.name,
    required this.height,
    required this.imageUrl,
    required this.types,
    required this.weight,
  });

  PokemonInfo.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'],
        height = json['height'],
        weight = json['weight'],
        imageUrl = json['sprites']['front_default'],
        types = (json['types'] as Iterable<dynamic>)
            .map<String>((e) => e['type']['name'])
            .toList();

  Map<String, Object> toJson() {
    return {
      'name': name,
      'height': height,
      'weight': weight,
      'sprites': {
        'front_default': imageUrl,
      },
      'types': types
          .map((e) => {
                'type': {'name': e}
              })
          .toList(),
    };
  }

  String getStringFromTypes() {
    String res = '';
    for (int i = 0; i < types.length; i++) {
      if (i == types.length - 1) {
        res += types[i];
      } else {
        res += "${types[i]}, ";
      }
    }
    return res;
  }
}
