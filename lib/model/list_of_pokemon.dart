import 'dart:convert';

class Pokemon {
  String name;
  String url;

  Pokemon({
    required this.name,
    required this.url,
  });

  Pokemon.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'],
        url = json['url'];

  Map<String, Object> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}

class ListOfPokemon {
  String prevUrl;
  String nextUrl;
  String currentUrl;
  List<Pokemon> list;

  ListOfPokemon({
    required this.list,
    required this.prevUrl,
    required this.nextUrl,
    required this.currentUrl,
  });

  ListOfPokemon.fromJson(Map<dynamic, dynamic> json, String url)
      : prevUrl = json['previous'] ?? 'null',
        nextUrl = json['next'] ?? 'null',
        currentUrl = url,
        list = (json['results'] as Iterable<dynamic>).map<Pokemon>((e) => Pokemon.fromJson(e)).toList();

  Map<String, Object> toJson() {
    return {
      'previous': prevUrl,
      'next': nextUrl,
      'results': list,
    };
  }
}
