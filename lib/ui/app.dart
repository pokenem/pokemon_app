import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pokemon_app/data/api_provider.dart';
import 'package:pokemon_app/data/persistence_manager.dart';
import 'package:pokemon_app/ui/pages/error_page.dart';
import 'package:pokemon_app/ui/pages/loading_page.dart';
import 'package:pokemon_app/ui/pages/pokemon_info_page.dart';
import 'package:get_it/get_it.dart';

import '../domain/main_bloc.dart';
import '../domain/main_state.dart';
import 'pages/main_page.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key) {
    GetIt.I.registerSingleton<Logger>(Logger());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (context) =>
          MainBloc(APIProvider(), PersistenceManager())..init(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainStateLoading) {
            return LoadingPage(
              backUrl: state.backUrl,
              loadingName: state.loadingName,
            );
          } else if (state is MainStateError) {
            return ErrorPage(
              error: state.error,
              retryUrl: state.retryUrl,
              retryName: state.retryName,
              backUrl: state.backUrl,
            );
          } else if (state is MainStateList) {
            return MainPage(list: state.listOfPokemon);
          } else if (state is MainStateInfo) {
            return PokemonInfoPage(
                pokemonInfo: state.pokemonInfo, backUrl: state.backUrl);
          }
          return ErrorPage(
            error: 'Something went wrong',
            retryUrl: APIProvider.baseUrl,
            retryName: 'main',
            backUrl: APIProvider.baseUrl,
          );
        },
      ),
    );
  }
}
