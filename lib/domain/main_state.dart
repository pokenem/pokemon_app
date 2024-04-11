import 'package:pokemon_app/model/list_of_pokemon.dart';
import 'package:pokemon_app/model/pokemon_info.dart';

class MainState{
  const MainState();
}

class MainStateError extends MainState{
  final String error;
  final String retryUrl;
  final String retryName;
  const MainStateError({required this.error, required this.retryUrl, required this.retryName});
}

class MainStateLoading extends MainState{
  const MainStateLoading();
}

class MainStateInfo extends MainState{
  final PokemonInfo pokemonInfo;
  final String backUrl;
  const MainStateInfo({required this.pokemonInfo, required this.backUrl});
}

class MainStateList extends MainState{
  final ListOfPokemon listOfPokemon;
  const MainStateList({required this.listOfPokemon});
}