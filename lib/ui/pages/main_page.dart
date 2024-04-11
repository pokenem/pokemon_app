import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/model/list_of_pokemon.dart';

import '../../domain/main_bloc.dart';

class MainPage extends StatelessWidget {
  final ListOfPokemon list;

  const MainPage({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(list.prevUrl);
    print(list.nextUrl);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('PokemonApp'),
        actions: [
          list.prevUrl != 'null'
              ? IconButton(
                  onPressed: () {
                    BlocProvider.of<MainBloc>(context).loadMain(list.prevUrl!);
                  },
                  icon: Icon(Icons.arrow_back_rounded))
              : Container(),
          list.nextUrl != 'null'
              ? IconButton(
                  onPressed: () {
                    BlocProvider.of<MainBloc>(context).loadMain(list.nextUrl!);
                  },
                  icon: Icon(Icons.arrow_forward_rounded))
              : Container(),
        ],
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            list.list.length,
            (index) => GestureDetector(
              onTap: () {
                BlocProvider.of<MainBloc>(context).loadInfo(list.list[index].url);
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  child: Center(
                    child: Text(
                      list.list[index].name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
