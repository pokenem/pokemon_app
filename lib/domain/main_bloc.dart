import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pokemon_app/data/api_provider.dart';
import 'package:pokemon_app/model/pokemon_info.dart';

import '../data/persistence_manager.dart';
import '../model/list_of_pokemon.dart';
import 'main_state.dart';

class MainBloc extends Cubit<MainState> {
  final APIProvider _apiProvider;
  final PersistenceManager _persistenceManager;

  MainBloc(this._apiProvider, this._persistenceManager)
      : super(MainStateLoading(
            loadingName: 'main', backUrl: APIProvider.baseUrl));

  void init() async {
    GetIt.I<Logger>().i('The first loading of the main page');
    await _persistenceManager.openBox();
    ListOfPokemon? list =
        await _persistenceManager.getListOfPokemon(APIProvider.baseUrl);
    if (list == null) {
      GetIt.I<Logger>().w(
          'The information is missing in Hive, Trying to download it from the api');
      try {
        list = await _apiProvider.getListOfPokemon(APIProvider.baseUrl);
      } catch (error) {
        GetIt.I<Logger>().w('The api is not responding either');
        emit(MainStateError(
            error: 'Network error',
            retryUrl: APIProvider.baseUrl,
            retryName: 'main',
            backUrl: APIProvider.baseUrl));
        return;
      }
      _persistenceManager.addListOfPokemon(APIProvider.baseUrl, list);
    }
    GetIt.I<Logger>().i('Main page information has been uploaded');
    emit(MainStateList(listOfPokemon: list));
  }

  void changeState(MainState state) {
    emit(state);
  }

  void loadMain(String url) async {
    GetIt.I<Logger>().i('Loading main page...');
    String backUrl = '';
    String loadingName = '';
    if (state is MainStateList) {
      backUrl = (state as MainStateList).listOfPokemon.currentUrl;
      loadingName = 'main';
    } else if (state is MainStateError) {
      backUrl = (state as MainStateError).backUrl;
      loadingName = (state as MainStateError).retryName;
    } else if (state is MainStateInfo) {
      backUrl = (state as MainStateInfo).backUrl;
      loadingName = 'main';
    }

    emit(MainStateLoading(backUrl: backUrl, loadingName: loadingName));

    ListOfPokemon? list = await _persistenceManager.getListOfPokemon(url);
    if (list == null) {
      GetIt.I<Logger>().w(
          'The information is missing in Hive, Trying to download it from the api');
      try {
        list = await _apiProvider.getListOfPokemon(url);
      } catch (error) {
        GetIt.I<Logger>().w('The api is not responding either');
        emit(MainStateError(
            error: 'Network error',
            retryUrl: url,
            retryName: 'main',
            backUrl: (state as MainStateLoading).backUrl));
        return;
      }
      _persistenceManager.addListOfPokemon(url, list);
    }
    GetIt.I<Logger>().i('Main page information has been uploaded');
    emit(MainStateList(listOfPokemon: list));
  }

  void loadInfo(String url) async {
    GetIt.I<Logger>().i('Loading info about pokemon...');
    String backUrl = '';
    String loadingName = '';
    if (state is MainStateList) {
      backUrl = (state as MainStateList).listOfPokemon.currentUrl;
      emit(MainStateLoading(backUrl: backUrl, loadingName: 'main'));
    } else if (state is MainStateError) {
      backUrl = (state as MainStateError).backUrl;
      loadingName = (state as MainStateError).retryName;
      emit(MainStateLoading(backUrl: backUrl, loadingName: loadingName));
    }

    PokemonInfo? poke = await _persistenceManager.getPokemonInfo(url);
    if (poke == null) {
      GetIt.I<Logger>().w(
          'The information is missing in Hive, Trying to download it from the api');
      try {
        poke = await _apiProvider.getPokemonInfo(url);
      } catch (error) {
        GetIt.I<Logger>().w('The api is not responding either');
        emit(MainStateError(
            error: 'Network error',
            retryUrl: url,
            retryName: 'info',
            backUrl: (state as MainStateLoading).backUrl));
        return;
      }
      _persistenceManager.addPokemonInfo(url, poke);
    }
    GetIt.I<Logger>().i('Pokemon information has been uploaded');
    emit(MainStateInfo(pokemonInfo: poke, backUrl: backUrl));
  }
}
