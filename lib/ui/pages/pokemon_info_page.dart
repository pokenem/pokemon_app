import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/model/pokemon_info.dart';
import 'package:pokemon_app/ui/widgets/info_tile.dart';

import '../../domain/main_bloc.dart';

class PokemonInfoPage extends StatelessWidget {
  final PokemonInfo pokemonInfo;
  final String backUrl;

  const PokemonInfoPage({Key? key, required this.pokemonInfo, required this.backUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<MainBloc>(context).loadMain(backUrl);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          CachedNetworkImage(imageUrl: pokemonInfo.imageUrl),
          SizedBox(
            height: 20,
          ),
          InfoTile(title: 'Name: ' + pokemonInfo.name),
          SizedBox(
            height: 20,
          ),
          InfoTile(title: 'Weight: ' + pokemonInfo.weight.toString()),
          SizedBox(
            height: 20,
          ),
          InfoTile(title: 'Height: ' + pokemonInfo.height.toString()),
          SizedBox(
            height: 20,
          ),
          InfoTile(title: 'Types: ' + pokemonInfo.getStringFromTypes()),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
