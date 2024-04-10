import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

import '../model/list_of_pokemon.dart';
import '../model/pokemon_info.dart';

class PersistenceManager {
  PersistenceManager();

  late Box box_pages;
  late Box box_info;

  Future<void> openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box_pages = await Hive.openBox("box_pages");
    box_info = await Hive.openBox("box_info");
  }

  Future<PokemonInfo?> getPokemonInfo(String url) async {
    final json = await box_info.get(url);
    if (json == null) {
      return null;
    } else {
      return PokemonInfo.fromJson(jsonDecode(json));
    }
  }

  Future<ListOfPokemon?> getListOfPokemon(String url) async {
    final json = await box_pages.get(url);
    if (json == null) {
      return null;
    } else {
      return ListOfPokemon.fromJson(jsonDecode(json), url);
    }
  }

  Future<void> addPokemonInfo(String url, PokemonInfo pokemonInfo) async{
    await box_info.put(url, jsonEncode(pokemonInfo.toJson()));
  }

  Future<void> addListOfPokemon(String url, ListOfPokemon listOfPokemon) async{
    await box_pages.put(url,jsonEncode(listOfPokemon.toJson()));
  }
}
