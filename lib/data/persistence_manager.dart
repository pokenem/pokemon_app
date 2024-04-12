import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

import '../model/list_of_pokemon.dart';
import '../model/pokemon_info.dart';

class PersistenceManager {
  PersistenceManager();

  late Box boxPages;
  late Box boxInfo;

  Future<void> openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    boxPages = await Hive.openBox("boxPages");
    boxInfo = await Hive.openBox("boxInfo");
    GetIt.I<Logger>().i('Hive initialized');
  }

  Future<PokemonInfo?> getPokemonInfo(String url) async {
    final json = await boxInfo.get(url);
    if (json == null) {
      return null;
    } else {
      return PokemonInfo.fromJson(jsonDecode(json));
    }
  }

  Future<ListOfPokemon?> getListOfPokemon(String url) async {
    final json = await boxPages.get(url);
    if (json == null) {
      return null;
    } else {
      return ListOfPokemon.fromJson(jsonDecode(json), url);
    }
  }

  Future<void> addPokemonInfo(String url, PokemonInfo pokemonInfo) async {
    await boxInfo.put(url, jsonEncode(pokemonInfo.toJson()));
    GetIt.I<Logger>().i('Add PokemonInfo in Hive');
  }

  Future<void> addListOfPokemon(String url, ListOfPokemon listOfPokemon) async {
    await boxPages.put(url, jsonEncode(listOfPokemon.toJson()));
    GetIt.I<Logger>().i('Add ListOfPokemon in Hive');
  }
}
