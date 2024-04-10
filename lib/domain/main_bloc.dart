import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/data/api_provider.dart';
import 'package:pokemon_app/model/pokemon_info.dart';

import '../data/persistence_manager.dart';
import '../model/list_of_pokemon.dart';
import 'main_state.dart';

class MainBloc extends Cubit<MainState> {
  final APIProvider _apiProvider;
  final PersistenceManager _persistenceManager;

  MainBloc(this._apiProvider, this._persistenceManager) : super(MainStateLoading());

  void init() async {
    await _persistenceManager.openBox();
    ListOfPokemon? list = await _persistenceManager.getListOfPokemon(APIProvider.baseUrl);
    if (list == null) {
      try {
        list = await _apiProvider.getListOfPokemon(APIProvider.baseUrl);
      } catch (error) {
        emit(MainStateError(error: error.toString()));
        return;
      }
      _persistenceManager.addListOfPokemon(APIProvider.baseUrl, list);
    }
    emit(MainStateList(listOfPokemon: list));
  }

  void changeState(MainState state) {
    emit(state);
  }

  void loadMain(String url) async {
    emit(MainStateLoading());
    ListOfPokemon? list = await _persistenceManager.getListOfPokemon(url);
    if (list == null) {
      try {
        list = await _apiProvider.getListOfPokemon(url);
      } catch (error) {
        emit(MainStateError(error: error.toString()));
        return;
      }
      _persistenceManager.addListOfPokemon(url, list);
    }
    emit(MainStateList(listOfPokemon: list));
  }

  void loadInfo(String url) async {
      final currentUrl = (state as MainStateList).listOfPokemon.currentUrl;
    emit(MainStateLoading());
    PokemonInfo? poke = await _persistenceManager.getPokemonInfo(url);
    if (poke == null) {
      try {
        poke = await _apiProvider.getPokemonInfo(url);
      } catch (error) {
        emit(MainStateError(error: error.toString()));
        return;
      }
      _persistenceManager.addPokemonInfo(url, poke);
    }
    emit(MainStateInfo(pokemonInfo: poke, backUrl: currentUrl));
  }

}