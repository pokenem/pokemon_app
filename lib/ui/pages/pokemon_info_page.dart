import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/model/pokemon_info.dart';
import 'package:pokemon_app/ui/widgets/info_tile.dart';

import '../../domain/main_bloc.dart';

class PokemonInfoPage extends StatelessWidget {
  final PokemonInfo pokemonInfo;
  final String backUrl;

  const PokemonInfoPage(
      {Key? key, required this.pokemonInfo, required this.backUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<MainBloc>(context).loadMain(backUrl);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              BlocProvider.of<MainBloc>(context).loadMain(backUrl);
            },
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            CachedNetworkImage(imageUrl: pokemonInfo.imageUrl),
            const SizedBox(
              height: 20,
            ),
            InfoTile(title: 'Name: ${pokemonInfo.name}'),
            const SizedBox(
              height: 20,
            ),
            InfoTile(title: 'Weight: ${pokemonInfo.weight}'),
            const SizedBox(
              height: 20,
            ),
            InfoTile(title: 'Height: ${pokemonInfo.height}'),
            const SizedBox(
              height: 20,
            ),
            InfoTile(title: 'Types: ${pokemonInfo.getStringFromTypes()}'),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
