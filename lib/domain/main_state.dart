import 'package:pokemon_app/model/list_of_pokemon.dart';
import 'package:pokemon_app/model/pokemon_info.dart';

class MainState{
  const MainState();
}

class MainStateError extends MainState{
  final String error;
  const MainStateError({required this.error});
}

class MainStateLoading extends MainState{
  const MainStateLoading();
}

class MainStateInfo extends MainState{
  final PokemonInfo pokemonInfo;
  const MainStateInfo({required this.pokemonInfo});
}

class MainStateList extends MainState{
  final ListOfPokemon listOfPokemon;
  const MainStateList({required this.listOfPokemon});
}