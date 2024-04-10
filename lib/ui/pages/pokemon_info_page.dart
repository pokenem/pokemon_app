
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/model/pokemon_info.dart';

import '../../domain/main_bloc.dart';

class PokemonInfoPage extends StatelessWidget {
  final PokemonInfo pokemonInfo;
  final String backUrl;
  const PokemonInfoPage({Key? key, required this.pokemonInfo, required this.backUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){BlocProvider.of<MainBloc>(context).loadMain(backUrl);},),
      ),
      body: Placeholder(),
    );
  }
}
