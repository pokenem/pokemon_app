import 'package:dio/dio.dart';
import 'package:pokemon_app/model/list_of_pokemons.dart';

import '../model/pokemon_info.dart';

class APIProvider {
  APIProvider();

  static String baseUrl = 'https://pokeapi.co/api/v2/pokemon';
  final Dio _dio = Dio();

  Future<ListOfPokemon> getListOfPokemon(String url) async{
    Response resp = await _dio.get(url);
    ListOfPokemon res = ListOfPokemon.fromJson(resp.data);
    return res;
  }

  Future<PokemonInfo> getPokemonInfo(String url) async{
    Response resp = await _dio.get(url);
    PokemonInfo res = PokemonInfo.fromJson(resp.data);
    return res;
  }

}