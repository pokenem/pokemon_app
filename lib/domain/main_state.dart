import 'package:pokemon_app/model/list_of_pokemon.dart';
import 'package:pokemon_app/model/pokemon_info.dart';

class MainState {
  const MainState();
}

class MainStateError extends MainState {
  final String error;
  final String retryUrl;
  final String backUrl;
  final String retryName;
  const MainStateError(
      {required this.error,
      required this.retryUrl,
      required this.retryName,
      required this.backUrl});
}

class MainStateLoading extends MainState {
  final String backUrl;
  final String loadingName;
  const MainStateLoading({required this.backUrl, required this.loadingName});
}

class MainStateInfo extends MainState {
  final PokemonInfo pokemonInfo;
  final String backUrl;
  const MainStateInfo({required this.pokemonInfo, required this.backUrl});
}

class MainStateList extends MainState {
  final ListOfPokemon listOfPokemon;
  const MainStateList({required this.listOfPokemon});
}
