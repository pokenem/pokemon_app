import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/model/list_of_pokemon.dart';

import '../../domain/main_bloc.dart';

class MainPage extends StatelessWidget {
  final ListOfPokemon list;
  const MainPage({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView.builder(
          itemCount: list.list.length,
          itemBuilder: (context, index) {
            return ListTile(onTap: (){BlocProvider.of<MainBloc>(context).loadInfo(list.list[index].url);},title: Text(list.list[index].name));
          },
        ),
      ),
    );
  }
}
