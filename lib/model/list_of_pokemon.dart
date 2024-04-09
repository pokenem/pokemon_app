class Pokemon {
  String name;
  String url;

  Pokemon({
    required this.name,
    required this.url,
  });

  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];
}

class ListOfPokemon {
  String? prevUrl;
  String? nextUrl;
  List<Pokemon> list;

  ListOfPokemon({
    required this.list,
    required this.prevUrl,
    required this.nextUrl,
  });

  ListOfPokemon.fromJson(Map<String, dynamic> json)
      : prevUrl = json['previous'],
        nextUrl = json['next'],
        list = (json['results'] as Iterable<dynamic>).map<Pokemon>((e) => Pokemon.fromJson(e)).toList();
}
