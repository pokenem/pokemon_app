import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/data/api_provider.dart';
import 'package:pokemon_app/model/pokemon_info.dart';

import '../model/list_of_pokemon.dart';
import 'main_state.dart';

class MainBloc extends Cubit<MainState> {
  final APIProvider _apiProvider;
  MainBloc(this._apiProvider) : super(MainStateLoading());

  void init() async{
      emit(MainStateLoading());
      ListOfPokemon list = await _apiProvider.getListOfPokemon(APIProvider.baseUrl);
      emit(MainStateList(listOfPokemon: list));
  }

  void changeState(MainState state){
      emit(state);
  }

  void loadMain(String url) async{
      emit(MainStateLoading());
      ListOfPokemon list = await _apiProvider.getListOfPokemon(url);
      emit(MainStateList(listOfPokemon: list));
  }

  void loadInfo(String url) async{
    emit(MainStateLoading());
    PokemonInfo poke = await _apiProvider.getPokemonInfo(url);
    emit(MainStateInfo(pokemonInfo: poke));
  }

}